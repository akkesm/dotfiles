{ pkgs, ... }:

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
    telegram-desktop

    # Games
    lutris
    nexusmods-app-unfree
    (olympus.override { celesteWrapper = "steam-run"; })
    scarab
    steam
    wineWowPackages.waylandFull
  ];
}
