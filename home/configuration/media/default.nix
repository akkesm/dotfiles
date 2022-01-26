{ config, pkgs, ... }:

{
  imports = [
    ./beets.nix
    ./easyeffects.nix
    ./mpd.nix
    ./mpv.nix
  ];
}
