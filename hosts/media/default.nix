{ ... }:

{
  imports = [
    ./hardware.nix
    # ./navidrome.nix
    ./networking.nix
    ./nginx.nix
    ./transmission.nix
    ./users.nix
    # ./vaultwarden.nix
    # ./wireguard.nix
  ];

  system.stateVersion = "23.05";
}
