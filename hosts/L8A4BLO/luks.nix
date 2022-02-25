{ config, pkgs, ... }:

{
  boot.initrd = {
    kernelModules = [
      "vfat"
      "nls_cp437"
      "nls_iso8859-1"
      "usbhid"
    ];

    luks = {
      yubikeySupport = true;

      devices = {
        "nixos-enc" = {
          device = "/dev/nvme0n1p2";
          preLVM = true;
          yubikey = {
            gracePeriod = 20;
            slot = 2;
            storage.device = "/dev/nvme0n1p1";
            twoFactor = true;
          };
        };  
      };
    };
  };
}
