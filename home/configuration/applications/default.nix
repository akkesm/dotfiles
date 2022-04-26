{ pkgs, ... }:

{
  imports = [
    ./chat.nix
    ./documents.nix
    ./firefox.nix
    ./games.nix
    ./lbry.nix
    ./matlab.nix
    ./packet-tracer.nix
    ./qutebrowser.nix
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
