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
}
