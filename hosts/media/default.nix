{ ... }:

{
  imports = [
    ./hardware.nix
    ./navidrome.nix
    ./networking.nix
    ./nginx.nix
    ./monitoring.nix
    ./torrenting.nix
    ./users.nix
    # ./vaultwarden.nix
    ./wireguard.nix
  ];

  system.stateVersion = "24.11";
}
