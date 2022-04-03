{ config, pkgs, ... }:

{
  gtk = {
    enable = true;

    cursorTheme = {
      package = pkgs.nordzy-cursors;
      name = "Nordzy-cursors";
      size = 24;
    };

    gtk2.configLocation = "${config.xdg.configHome}/gtk-2.0/gtkrc";

    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = true;
    };

    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = true;
    };

    iconTheme = {
      package = pkgs.nordzy-icon-theme;
      name = "Nordzy-orange-dark";
    };

    theme = {
      package = pkgs.nordic;
      name = "Nordic";
    };
  };

  home.packages = with pkgs; [
    # gnome-themes-extra
    hicolor-icon-theme
  ];
}
