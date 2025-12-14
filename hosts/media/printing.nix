{ lib, pkgs, ... }:

{
  environment.etc."ipp-usb/ipp-usb.conf".text = ''
    [network]
    interface = all
  '';

  hardware.printers.ensurePrinters = [{
    description = "Canon PIXMA G2570";
    deviceUri = "usb://Canon/G2070%20series?serial=032A14&interface=1";
    model = "gutenprint.${lib.versions.majorMinor (lib.getVersion pkgs.gutenprint)}://bjc-PIXMA-G2500/expert";
    name = "Canon_PIXMA_G2570";
  }];

  networking.firewall = {
    allowedTCPPortRanges = [
      {
        from = 60000;
        to = 65535;
      }
    ];

    allowedTCPPorts = [ 515 ];
  };

  services = {
    printing = {
      allowFrom = [ "all" ];
      browsing = true;
      defaultShared = true;
      listenAddresses = [ "*:631" ];
      logLevel = "debug";
      openFirewall = true;
    };
  };
}

