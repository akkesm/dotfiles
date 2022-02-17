{ config, pkgs, ... }:

{
  accounts.email.accounts.${config.home.username} = {
    primary = true;
    address = "alessandro.barenghi@tuta.io";
    realName = "Alessandro Barenghi";

    gpg = {
      key = "50E2669CAB382F4A5F7216670D6BFC01D45EDADD";
      signByDefault = true;
    };
  };

  home = {
    username = "alessandro";
    homeDirectory = "/home/alessandro";

    packages = with pkgs; [
      cbonsai
      cowsay
      fortune
      lolcat
      nix-prefetch-scripts
      nixpkgs-review
      taskwarrior
      xdg-utils
    ];

    sessionVariables = {
      CFLAGS = "-march=native -pipe -O3";
      CXXFLAGS = config.home.sessionVariables.CFLAGS;
      PATH = "$HOME/.local/bin:$PATH";
    };
  };

  manual = {
    html.enable = true;
    manpages.enable = true;
  };

  news.display = "silent";

  services.kdeconnect = {
    enable = true;
    indicator = true;
  };

  xdg = {
    enable = true;
    configFile."mimeapps.list".force = true; # $XDG_CONFIG_HOME/mimeapps.list often gets overwritten
    cacheHome = "${config.home.homeDirectory}/.cache";
    configHome = "${config.home.homeDirectory}/.config";
    dataHome = "${config.home.homeDirectory}/.local/share";
    mime.enable = true;

    mimeApps = {
      enable = true;

      defaultApplications = {
        "inode/directory" = [ "org.kde.dolphin.desktop" ];
        "text/html" = [ "firefox.desktop" "chromium-browser.desktop" ];
        "x-scheme-handler/http" = [ "firefox.desktop" "chromium-browser.desktop" ];
        "x-scheme-handler/https" = [ "firefox.desktop" "chromium-browser.desktop" ];
      };
    };

    stateHome = "${config.home.homeDirectory}/.local/state";

    userDirs = {
      enable = true;
      createDirectories = true;
      desktop = "${config.home.homeDirectory}/Desktop";
      documents = "${config.home.homeDirectory}/Documents";
      download = "${config.home.homeDirectory}/Downloads";
      music = "${config.home.homeDirectory}/Music";
      pictures = "${config.home.homeDirectory}/Pictures";
      publicShare = "${config.home.homeDirectory}/Public";
      templates = "${config.home.homeDirectory}/Templates";
      videos = "${config.home.homeDirectory}/Videos";
    };
  };
}
