{ config, ... }:

{
  imports = [
    ./environment.nix
    ./mako.nix
    ./sway.nix
    ./swaylock.nix
    ./waybar.nix
  ];
}
