{
  inputs = {
    nix = {
      url = "github:NixOS/nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Channels
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-latest-stable.url = "github:NixOS/nixpkgs/nixos-22.05";

    nur.url = "github:nix-community/NUR";

    nixpkgs-wayland = {
      url = "github:nix-community/nixpkgs-wayland";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Helpers
    flake-utils-plus = {
      url = "github:gytis-ivaskevicius/flake-utils-plus";
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
    dirbuf-nvim = {
      url = "github:elihunter173/dirbuf.nvim";
      flake = false;
    };
    due_nvim = {
      url = "github:NFrid/due.nvim";
      flake = false;
    };
    neorg-telescope = {
      url = "github:nvim-neorg/neorg-telescope";
      flake = false;
    };
    vim-latex = {
      url = "github:vim-latex/vim-latex";
      flake = false;
    };

    tree-sitter-norg-meta = {
      url = "github:nvim-neorg/tree-sitter-norg-meta";
      flake = false;
    };
    tree-sitter-norg-table = {
      url = "github:nvim-neorg/tree-sitter-norg-table";
      flake = false;
    };

    # Zig master branch
    zig = {
      url = "github:ziglang/zig";
      flake = false;
    };
  };

  outputs =
    { self
    , nix
    , nixpkgs
    , nixpkgs-latest-stable
    , nur
    , nixpkgs-wayland
    , flake-utils-plus
    , home-manager
    , sops-nix
    , impermanence
    , neovim
    , ...
    }@inputs:
    let
      lib = nixpkgs.lib.extend (final: prev: {
        my = import ./lib { lib = final; };
      });
    in
    flake-utils-plus.lib.mkFlake rec {
      inherit self inputs;

      supportedSystems = [ "x86_64-linux" ];

      channels = {
        nixpkgs = {
          input = nixpkgs;
          overlaysBuilder = channels: [
            # nix.overlay
            nixpkgs-wayland.overlay

            (final: prev: { neovim-master = neovim.defaultPackage.${prev.system}; })
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

        { nix.generateRegistryFromInputs = true; }
      ];

      hosts = {
        civetta.modules = [
          ./hosts/civetta
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.alessandro = import ./home;
            };
          }
        ];

        # nix build --impure .#nixosConfigurations.live.config.system.build.isoImage
        live = {
          channelName = "nixpkgs";

          modules = [
            ./hosts/live
            {
              imports = [
                (channels."${hosts.live.channelName}".input + "/nixos/modules/installer/cd-dvd/installation-cd-minimal-new-kernel.nix")
                (channels."${hosts.live.channelName}".input + "/nixos/modules/installer/cd-dvd/channel.nix")
              ];
            }
            {
              system.stateVersion = "22.11";
            }

            # home-manager.nixosModules.home-manager
            # {
            #   home-manager.useGlobalPkgs = true;
            #   home-manager.useUserPackages = true;
            #   home-manager.users."alessandro" = import ./home;
            # }
          ];
        };

        media = {
          channelName = "nixpkgs-latest-stable";
          modules = [ ./hosts/media ];
        };
      };

      overlay = import ./overlays {
        inherit lib;
        inherit (self) inputs;
      };
      overlays = flake-utils-plus.lib.exportOverlays { inherit (self) pkgs inputs; };

      outputsBuilder = channels: rec {
        packages = flake-utils-plus.lib.exportPackages self.overlays channels;

        devShells = import ./shells { pkgs = self.pkgs.x86_64-linux.nixpkgs; };
      };

      templates.default = {
        path = ./templates/default;
        description = "Default flake template";
      };
    };
}
