{ config, pkgs, ... }:

{
  programs.dconf.enable = true;

  xdg.portal = {
    enable = true;
    wlr.enable = true;

    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-kde
    ];

    gtkUsePortal = true;
  };

  security.pam.services.swaylock = {};
}
