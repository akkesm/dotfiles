{ pkgs, ... }:

{
  networking.firewall = {
    # KDE Connect
    allowedTCPPortRanges = [{ from = 1714; to = 1764; }];
    allowedUDPPortRanges = [{ from = 1714; to = 1764; }];
  };

  programs.dconf.enable = true;
  programs.droidcam.enable = true;

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
