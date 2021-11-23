{ config, ... }:

{
  imports = [
    ./auth.nix
    ./theme.nix
    ./environment.nix
    ./applications
    ./desktop
    ./terminal
  ];

  home.stateVersion = "21.11";
}
