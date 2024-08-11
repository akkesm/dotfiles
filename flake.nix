{
  inputs = {
    # Channels
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
    unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    nur.url = "github:nix-community/NUR";
    # nixpkgs-wayland.url = "github:nix-community/nixpkgs-wayland";
    olympus-nixpkgs.url = "github:Petingoso/nixpkgs/olympus";

    # Helpers
    flake-utils-plus.url = "github:gytis-ivaskevicius/flake-utils-plus";
    deploy-rs.url = "github:serokell/deploy-rs";

    # luks-yk = {
    #   url = "github:akkesm/luks-yk";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    # Extra modules
    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager-unstable = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "unstable";
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
    nnn-nvim = {
      url = "github:luukvbaal/nnn.nvim";
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
    , unstable
    , nur
      # , nixpkgs-wayland
    , olympus-nixpkgs
    , flake-utils-plus
    , deploy-rs
    , home-manager
    , home-manager-unstable
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

      channels = {
        nixpkgs = {
          input = nixpkgs;
          # overlaysBuilder = channels: [ nixpkgs-wayland.overlay ];
        };

        unstable.input = unstable;

        unstable.overlaysBuilder = channels: [ (final: prev: { inherit (channels.olympus-nixpkgs) olympus; }) ];
        olympus.input = olympus-nixpkgs;
      };

      channelsConfig = {
        allowUnfree = true;
        contentAddressableByDefault = true;
      };

      sharedOverlays = [
        self.overlay

        nur.overlay
        sops-nix.overlays.default
      ];

      hostDefaults.modules = [
        ./common
        sops-nix.nixosModules.sops
        impermanence.nixosModules.impermanence

        { nix.generateRegistryFromInputs = false; }
      ];

      hosts = {
        civetta = {
          channelName = "unstable";
          modules = [
            ./hosts/civetta
            home-manager-unstable.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                users.alessandro = import ./home;
              };
            }
          ];
        };

        # nix build .#nixosConfigurations.wsl.config.system.build.installer
        wsl.modules = [
          nixos-wsl.nixosModules.wsl
          {
            wsl = {
              enable = true;

              wslConf = {
                automount.root = "/mnt";
                network.generateResolvConf = false;
              };

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

      outputsBuilder = channels: {
        packages = flake-utils-plus.lib.exportPackages self.overlays channels;

        devShells = import ./shells { pkgs = self.pkgs.x86_64-linux.nixpkgs; };
      };

      templates.default = {
        path = ./templates/default;
        description = "Default flake template";
      };

      deploy.nodes = {
        media = {
          hostname = "192.168.178.3";

          profiles = {
            system = {
              sshUser = "root";
              path = inputs.deploy-rs.lib.x86_64-linux.activate.nixos self.nixosConfigurations.media;
              user = "root";
            };
          };
        };
      };

      checks = builtins.mapAttrs (system: deployLib: deployLib.deployChecks self.deploy) deploy-rs.lib;
    };
}
