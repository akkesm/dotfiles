{ config, pkgs, ... }:

{
  home = {
    packages = [ pkgs.qt5.qtwayland ];

    sessionVariables = {
      QT_QPA_PLATFORM = "wayland-egl";
      QT_WAYLAND_FORCE_DPI = 100;
    };
  };

  qt = {
    enable = true;
    platformTheme = "gtk";

    style.name = "gtk2";
  };
}
