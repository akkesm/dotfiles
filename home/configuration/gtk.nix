{ config, pkgs, ... }:

{
  gtk = {
    enable = true;
    gtk2.configLocation = "${config.xdg.configHome}/gtk-2.0/gtkrc";

    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = true;
      gtk-cursor-theme-name = "Nordzy-cursors";
    };

    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = true;
      gtk-cursor-theme-name = "Nordzy-cursors";
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
    nordzy-cursors
  ];

  wayland.windowManager.sway.wrapperFeatures.gtk = config.wayland.windowManager.sway.enable;
}
