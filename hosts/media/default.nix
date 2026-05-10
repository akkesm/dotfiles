{ ... }:

{
  imports = [
    ./cloudflared.nix
    ./ente.nix
    ./hardware.nix
    ./navidrome.nix
    ./networking.nix
    ./nginx.nix
    ./monitoring.nix
    ./printing.nix
    ./torrenting.nix
    ./users.nix
    # ./vaultwarden.nix
    ./wireguard.nix
  ];

  system.stateVersion = "25.11";
}
