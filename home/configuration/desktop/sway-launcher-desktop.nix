{ pkgs, ... }:

{
  wayland.windowManager.sway.config.menu =  "${pkgs.kitty}/bin/kitty --class=launcher ${pkgs.sway-launcher-desktop}/bin/sway-launcher-desktop";
  home.sessionVariables.TERMINAL_COMMAND = "${pkgs.kitty}/bin/kitty";
}
