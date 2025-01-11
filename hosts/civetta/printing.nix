{ lib, pkgs, ... }:

let
  EpsonSX600W-IP = "192.168.178.29";
in
{
  hardware = {
    printers = {
      ensureDefaultPrinter = "EPSONSX600FW";

      ensurePrinters = [{
        description = "Epson Stylus SX600FW";
        deviceUri = "socket://${EpsonSX600W-IP}";
        # model = "epson-inkjet-printer-escpr/Epson-Stylus_SX600FW-epson-escpr-en.ppd";
        model = "gutenprint.${lib.versions.majorMinor (lib.getVersion pkgs.gutenprint)}://escp2-sx600fw/expert";
        name = "EPSONSX600FW";

        ppdOptions = { PageSize = "A4"; };
      }];
    };

    sane = {
      enable = true;
      disabledDefaultBackends = [ "v4l" ];

      extraBackends = [
        pkgs.epkowa
        # pkgs.sane-backends
      ];
    };
  };

  networking.firewall.extraCommands = ''
    iptables -I INPUT -p udp -s ${EpsonSX600W-IP} -j ACCEPT
  '';

  services.printing = {
    enable = true;
    browsing = true;
    defaultShared = true;

    drivers = [
      # pkgs.epson-escpr
      pkgs.gutenprint
    ];

    logLevel = "debug";
    tempDir = "/var/spool/cups/tmp";
  };
}
