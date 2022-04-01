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
    ./ungoogled-chromium.nix
  ];

  home.packages = with pkgs; [
    dolphin
    gimp
    lbry
    qutebrowser
    transmission-gtk
    # openclonk
    # passky
  ];
}
