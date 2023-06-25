{ config, ... }:

{
  imports = [
    ./hardware.nix
    # ./navidrome.nix
    ./networking.nix
    ./transmission.nix
    ./users.nix
    # ./vaultwarden.nix
    # ./wireguard.nix
  ];

  system.stateVersion = "23.05";
}
