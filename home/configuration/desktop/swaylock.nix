{ config, pkgs, ... }:

{
  home.packages = [ pkgs.swaylock ];

  xdg.configFile."swaylock/config".text = ''
    ignore-empty-password
    image=${../../..}/images/wallpaperNordNixLogo.png
    scaling=fill
    font=${config.fonts.monospace}
    font-size=14
  '';
}
