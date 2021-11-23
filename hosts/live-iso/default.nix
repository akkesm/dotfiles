{ config, pkgs, ... }:

{
  networking = {
    firewall = {
      enable = true;
      package = pkgs.iptables-nftables-compat;
    };

    wireless = {
      enable = true;
      userControlled.enable = true;
    };
  };

  services = {
    openssh.enable = true;
    pcscd.enable = true;

    udev.packages = [
      pkgs.yubikey-manager
      pkgs.yubikey-personalization
    ];
  };

  xdg.portal = {
    enable = true;
    wlr.enable = true;

    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-kde
    ];

    gtkUsePortal = true;
  };
}
