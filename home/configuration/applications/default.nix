{ pkgs, ... }:

{
  imports = [
    ./documents.nix
    ./firefox.nix
    ./lbry.nix
    # ./packet-tracer.nix
    ./qutebrowser.nix
  ];

  home.packages = with pkgs; [
    android-file-transfer
    dolphin
    gimp
    gwenview
    simple-scan
    teams-for-linux

    # Chat
    element-desktop
    tdesktop

    # Games
    lutris
    steam
  ];
}
