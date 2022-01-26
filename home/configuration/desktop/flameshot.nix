{ config, pkgs, ... }:

{
  services.flameshot = {
    enable = true;
    settings = {
      General = {
        disabledTrayIcon = false;
        uiColor = "#2e3440";
        contrastUiColor = "#88c0d0";
      };
    };
  };

  wayland.windowManager.sway.config.keycodebindings."107" = "exec ${pkgs.flameshot}/bin/flameshot gui";
}
