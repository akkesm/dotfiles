{
  inputs = {
    nix = {
      url = "github:NixOS/nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Channels
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-latest-stable.url = "github:NixOS/nixpkgs/nixos-21.11";

    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixpkgs-wayland = {
      url = "github:nix-community/nixpkgs-wayland";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Helpers
    utils = {
      url = "github:gytis-ivaskevicius/flake-utils-plus";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    dwarffs = {
      url = "github:edolstra/dwarffs";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # luks-yk = {
    #   url = "github:akkesm/luks-yk";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    # Extra modules
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    impermanence.url = "github:nix-community/impermanence";

    # Neovim and plugins
    neovim = {
      url = "github:neovim/neovim?dir=contrib";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    coq_nvim = {
      url = "github:ms-jpq/coq_nvim";
      flake = false;
    };
    coq_artifacts = {
      url = "github:ms-jpq/coq.artifacts";
      flake = false;
    };
    coq_thirdparty = {
      url = "github:ms-jpq/coq.thirdparty";
      flake = false;
    };
    dirbuf-nvim = {
      url = "github:elihunter173/dirbuf.nvim";
      flake = false;
    };
    due_nvim = {
      url = "github:NFrid/due.nvim";
      flake = false;
    };
    nabla-nvim = {
      url = "github:jbyuki/nabla.nvim";
      flake = false;
    };
    neorg-telescope = {
      url = "github:nvim-neorg/neorg-telescope";
      flake = false;
    };
    nvim-workbench = {
      url = "github:marcushwz/nvim-workbench";
      flake = false;
    };
    vim-latex = {
      url = "github:vim-latex/vim-latex";
      flake = false;
    };
    windline-nvim = {
      url = "github:windwp/windline.nvim";
      flake = false;
    };

    # Zig master branch
    zig = {
      url = "github:ziglang/zig";
      flake = false;
    };
  };

  outputs =
    { self, nix, utils, dwarffs
    , nixpkgs, nixpkgs-latest-stable, nur, nixpkgs-wayland, neovim
    , home-manager, sops-nix, impermanence
    , ... }@inputs:
    utils.lib.mkFlake {
      inherit self inputs;

      lib = nixpkgs.lib.extend (self: super: {
        my = import ./lib.nix { lib = self; };
      });

      supportedSystems = [ "x86_64-linux" ];

      channels = {
        nixpkgs = {
          input = nixpkgs;
          overlaysBuilder = channels: [
            nix.overlay
            nixpkgs-wayland.overlay

            (final: prev: {
              neovim-master = neovim.defaultPackage.${prev.system};
            })
          ];
        };

        nixpkgs-latest-stable.input = nixpkgs-latest-stable;
      };

      channelsConfig.allowUnfree = true;

      sharedOverlays = [
        self.overlay

        nur.overlay
        sops-nix.overlay
      ];

      hostDefaults.modules = [
        ./common
        sops-nix.nixosModules.sops
        impermanence.nixosModules.impermanence
      ];

      hosts = {
        "civetta".modules = [
          ./hosts/civetta
          # dwarffs.nixosModules.dwarffs

          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users."alessandro" = import ./home;
            };
          }
        ];

        # nix build --impure .#nixosConfigurations.live-iso.config.system.build.isoImage
        "live-iso".modules = [
          ./hosts/live-iso
          {
            imports = [
              (nixpkgs + "/nixos/modules/installer/cd-dvd/installation-cd-minimal-new-kernel.nix")
              (nixpkgs + "/nixos/modules/installer/cd-dvd/channel.nix")
            ];
          }

          # home-manager.nixosModules.home-manager
          # {
          #   home-manager.useGlobalPkgs = true;
          #   home-manager.useUserPackages = true;
          #   home-manager.users."alessandro" = import ./home;
          # }
        ];
      };

      overlay = import ./overlays { inherit (self) inputs; };
      overlays = utils.lib.exportOverlays { inherit (self) pkgs inputs; };

      outputsBuilder = channels: rec {
        packages = utils.lib.exportPackages self.overlays channels;

        devShells = import ./shells { pkgs = channels.nixpkgs; };
        devShell = devShells.sops;
      };
    };
}
