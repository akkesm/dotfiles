{ config, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./environment.nix
    ./kernel.nix
    ./media.nix
    ./networking.nix
    ./persistence.nix
    ./power.nix
    ./printing.nix
    ./security.nix
    ./users.nix
    ./virtualisation.nix
  ];

  system.stateVersion = "21.11";
}
