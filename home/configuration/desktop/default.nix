{ config, ... }:

{
  imports = [
    ./clipboard.nix
    ./flameshot.nix
    ./mako.nix
    ./sway.nix
    ./sway-launcher-desktop.nix
    ./swayidle.nix
    ./swaylock.nix
    ./waybar
  ];
}
