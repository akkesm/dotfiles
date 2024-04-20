{ lib, pkgs, ... }:

{
  environment = {
    sessionVariables = {
      NIXOS_OZONE_WL = "1";
      STEAM_FORCE_DESKTOPUI_SCALING = "1.5";
    };

    systemPackages = with pkgs; [ kdePackages.plasma-browser-integration ];
  };

  services = {
    desktopManager.plasma6.enable = true;

    displayManager.sddm = {
      enable = true;
      wayland.enable = true;
    };
  };

  services.greetd.enable = lib.mkForce false;
  services.tlp.enable = lib.mkForce false;
}
