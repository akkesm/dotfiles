{ pkgs, ... }:

{
  hardware.xpadneo.enable = true;

  networking.firewall = {
    # KDE Connect
    allowedTCPPortRanges = [{ from = 1714; to = 1764; }];
    allowedUDPPortRanges = [{ from = 1714; to = 1764; }];
  };

  programs.dconf.enable = true;
  programs.droidcam.enable = true;

  xdg.portal = {
    enable = true;

    config = {
      common.default = [ "gtk" ];
      sway.default = [ "wlr" "gtk" ];
    };

    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-kde
    ];

    wlr.enable = true;
  };

  security.pam.services.swaylock = { };
  services.udisks2.enable = true;

  containers.postgres = {
    config = { lib, pkgs, ... }: {
      services.postgresql = {
        enable = true;
        package = pkgs.postgresql_16;
      };

      system.stateVersion = "23.11";
    };
  };
}
