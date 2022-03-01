{ config, lib, pkgs, ... }:

{
  hardware.printers = {
    ensureDefaultPrinter = "EPSONSX600FW";

    ensurePrinters = [{
      description = "Epson Stylus SX600FW";
      deviceUri = "socket://192.168.178.31";
      model = "gutenprint.${lib.versions.majorMinor (lib.getVersion pkgs.gutenprint)}://escp2-sx600fw/expert";
      name = "EPSONSX600FW";

      ppdOptions = { PageSize = "A4"; };
    }];
  };

  services.printing = {
    enable = true;
    browsing = true;
    defaultShared = true;
    drivers = [ pkgs.gutenprint ];
    logLevel = "debug";
    tempDir = "/tmp/cups";
  };

  services.avahi = {
    enable = false;
    nssmdns = true;
  };
}