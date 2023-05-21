{ config, pkgs, ... }:

{
  boot.kernelPackages = pkgs.zfs.latestCompatibleLinuxPackages;

  xdg.portal = {
    enable = true;

    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-kde
    ];

    wlr.enable = true;
  };
}
