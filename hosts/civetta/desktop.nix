{ pkgs, ... }:

{
  programs.dconf.enable = true;

  xdg.portal = {
    enable = true;

    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-kde
    ];

    wlr.enable = true;
  };

  security.pam.services.swaylock = { };
}
