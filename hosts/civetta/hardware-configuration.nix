{ config, modulesPath, ... }:

{
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  boot = {
    initrd.availableKernelModules = [
      "nvme"
      "xhci_pci"
      "ahci"
      "usbhid"
      "usb_storage"
      "sd_mod"
    ];

    kernelModules = [ "kvm-amd" ];
    supportedFilesystems = [ "btrfs" ];
  };

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/8cf9299c-9120-4592-b838-c1e0b8b5928e";
      fsType = "btrfs";
      options = [ "subvol=root" "compress=zstd:2" "discard=async" "space_cache=v2" "ssd" "noatime"];
    };

    "/home" = {
      device = "/dev/disk/by-uuid/8cf9299c-9120-4592-b838-c1e0b8b5928e";
      fsType = "btrfs";
      options = [ "subvol=home" "compress=zstd:2" "discard=async" "space_cache=v2" "ssd" "noatime"];
    };

    "/nix" = {
      device = "/dev/disk/by-uuid/8cf9299c-9120-4592-b838-c1e0b8b5928e";
      fsType = "btrfs";
      options = [ "subvol=nix" "compress=zstd:2" "discard=async" "space_cache=v2" "ssd" "noatime"];
    };

    "/persist" = {
      device = "/dev/disk/by-uuid/8cf9299c-9120-4592-b838-c1e0b8b5928e";
      fsType = "btrfs";
      options = [ "subvol=persist" "compress=zstd:2" "discard=async" "space_cache=v2" "ssd" "noatime"];
      neededForBoot = true;
    };

    "/var/lib" = {
      device = "/dev/disk/by-uuid/8cf9299c-9120-4592-b838-c1e0b8b5928e";
      fsType = "btrfs";
      options = [ "subvol=lib" "compress=zstd:2" "discard=async" "space_cache=v2" "ssd" "noatime"];
      neededForBoot = true;
    };

    "/var/log" = {
      device = "/dev/disk/by-uuid/8cf9299c-9120-4592-b838-c1e0b8b5928e";
      fsType = "btrfs";
      options = [ "subvol=log" "compress=zstd:2" "discard=async" "space_cache=v2" "ssd" "noatime"];
      neededForBoot = true;
    };

    "/boot" = {
      device = "/dev/disk/by-uuid/5621-1D5E";
      fsType = "vfat";
    };
  };

  zramSwap = {
    enable = true;
    memoryPercent = 100;
  };
}
