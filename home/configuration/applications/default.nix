{ pkgs, olympus, ... }:

{
  imports = [
    ./documents.nix
    ./firefox.nix
    ./lbry.nix
    # ./packet-tracer.nix
    # ./qutebrowser.nix
  ];

  home.packages = with pkgs; [
    android-file-transfer
    kdePackages.dolphin
    gimp
    kdePackages.gwenview
    simple-scan
    teams-for-linux
    ungoogled-chromium

    # Chat
    discord
    element-desktop
    tdesktop

    # Games
    lutris
    scarab
    steam
    wineWowPackages.waylandFull

    olympus
  ];
}
