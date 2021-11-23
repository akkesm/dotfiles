{ config, pkgs, ... }:

{
  gtk = {
    enable = true;
    gtk2.configLocation = "${config.xdg.configHome}/gtk-2.0/gtkrc";

    iconTheme = {
      package = pkgs.nordzy-icon-theme;
      name = "Nordzy-orange-dark";
    };

    theme = {
      package = pkgs.nordic;
      name = "Nordic";
    };
  };

  home.packages = with pkgs; [ hicolor-icon-theme ];

  qt = {
    enable = true;
    platformTheme = "gtk";

    style.name = "gtk2";
  };
}
