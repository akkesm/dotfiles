{ ... }:

{
  boot.initrd = {
    kernelModules = [
      "vfat"
      "nls_cp437"
      "nls_iso8859-1"
      "usbhid"
    ];

    luks = {
      devices = {
        "nixos-enc" = {
          device = "/dev/nvme0n1p2";
          crypttabExtraOpts = ["fido2-device=auto"];
          preLVM = true;
        };
      };
    };
  };
}
