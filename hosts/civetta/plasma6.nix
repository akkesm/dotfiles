{ lib, pkgs, ... }:

{
  environment = {
    systemPackages = with pkgs; [ kdePackages.plasma-browser-integration ];
    variables.STEAM_FORCE_DESKTOPUI_SCALING = "1.5";
  };

  services.xserver = {
    enable = true;
    displayManager.sddm.enable = true;
    desktopManager.plasma6.enable = true;
  };

  services.tlp.enable = lib.mkForce false;
}
