{ pkgs, ... }:

{
  imports = [
    ./chat.nix
    ./documents.nix
    ./firefox.nix
    ./games.nix
    ./lbry.nix
    ./matlab.nix
    # ./packet-tracer.nix
    ./qutebrowser.nix
  ];

  home.packages = with pkgs; [
    android-file-transfer
    dolphin
    gimp
    lbry
    skanlite
    transmission-gtk
    # openclonk
    # passky
  ];
}
