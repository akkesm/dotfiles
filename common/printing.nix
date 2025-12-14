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
      disabledDefaultBackends = [
        "escl"
        "v4l"
      ];

      extraBackends = with pkgs; [
        (epkowa.overrideAttrs (oldAttrs: {
          postInstall = oldAttrs.postInstall + ''
            echo "net ${EpsonSX600W-IP}" >> $out/etc/sane.d/epkowa.conf
          '';
        }))

        sane-airscan
      ];
    };
  };

  networking.firewall.extraCommands = ''
    iptables -I INPUT -p udp -s ${EpsonSX600W-IP} -j ACCEPT
  '';

  services = {
    avahi = {
      enable = true;
      nssmdns4 = true;
    };

    ipp-usb.enable = true;

    printing = {
      enable = true;
      browsing = true;
      cups-pdf.enable = true;

      drivers = with pkgs; [
        # epson-escpr
        canon-cups-ufr2
        gutenprint
      ];

      tempDir = "/var/spool/cups/tmp";
    };

    udev.packages = with pkgs; [
      sane-airscan
    ];
  };
}

