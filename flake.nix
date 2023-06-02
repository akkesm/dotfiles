{
  inputs = {
    # Channels
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.05";
    nur.url = "github:nix-community/NUR";
    # nixpkgs-wayland.url = "github:nix-community/nixpkgs-wayland";

    # Helpers
    flake-utils-plus.url = "github:gytis-ivaskevicius/flake-utils-plus";

    # luks-yk = {
    #   url = "github:akkesm/luks-yk";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    # Extra modules
    home-manager = {
      url = "github:nix-community/home-manager/release-23.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix.url = "github:Mic92/sops-nix";
    impermanence.url = "github:nix-community/impermanence";
    nixos-wsl.url = "github:nix-community/NixOS-WSL";

    # Neovim and plugins
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

    # Tree-sitter grammars
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
    , nixpkgs
    , nur
    # , nixpkgs-wayland
    , flake-utils-plus
    , home-manager
    , nixos-wsl
    , sops-nix
    , impermanence
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

      channels.nixpkgs = {
        input = nixpkgs;
        # overlaysBuilder = channels: [ nixpkgs-wayland.overlay ];
      };

      channelsConfig.allowUnfree = true;

      sharedOverlays = [
        self.overlay

        nur.overlay
        sops-nix.overlays.default
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

        # nix build .#nixosConfigurations.wsl.config.system.build.installer
        wsl.modules = [
          nixos-wsl.nixosModules.wsl
          {
            wsl = {
              enable = true;
              automountPath = "/mnt";
              defaultUser = "alessandro";
              startMenuLaunchers = true;
            };

            system.stateVersion = "22.11";
          }

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
        live.channelName = "nixpkgs";
        live.modules = [
          ./hosts/live
          {
            imports = [
              (channels."${hosts.live.channelName}".input + "/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix")
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

        media = {
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
