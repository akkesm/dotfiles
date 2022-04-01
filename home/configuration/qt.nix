{ pkgs, ... }:

{
  home = {
    packages = [ pkgs.qt5.qtwayland ];

    sessionVariables = {
      QT_WAYLAND_DISABLE_WINDOWDECORATION = 1;
      QT_WAYLAND_FORCE_DPI = 100;
    };
  };

  qt = {
    enable = true;
    platformTheme = "gtk";
    style.name = "gtk2";
  };
}
