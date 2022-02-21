{ config, pkgs, ... }:

{
  imports = [
    ./chat.nix
    ./documents.nix
    ./firefox.nix
    ./games.nix
    ./matlab.nix
    ./packet-tracer.nix
    ./ungoogled-chromium.nix
  ];

  home.packages = with pkgs; [
    dolphin
    gimp
    lbry
    transmission-gtk
    # openclonk
    # passky
  ];
}
