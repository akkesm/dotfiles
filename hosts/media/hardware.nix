{ ... }:

{
  boot = {
    initrd.availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usbhid" "usb_storage" "sd_mod" "sdhci_pci" ];
    kernelModules = [ "kvm-intel" ];

    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };

  fileSystems = {
    "/" =
      {
        device = "/dev/disk/by-uuid/9adf901b-b846-48b7-ad73-51f6241b4a63";
        fsType = "btrfs";
        options = [ "subvol=root" "compress=zstd" "noatime" ];
      };

    "/data" =
      {
        device = "/dev/disk/by-uuid/c3e8e9e9-17a4-4e01-9f7d-3b80f9c3790f";
        fsType = "btrfs";
        options = [ "compress=zstd" "subvol=dataroot" ];
      };

    "/var/lib/lidarr" =
      {
        device = "/dev/disk/by-uuid/c3e8e9e9-17a4-4e01-9f7d-3b80f9c3790f";
        fsType = "btrfs";
        options = [ "compress=zstd" "subvol=var/lib/lidarr" ];
      };

    "/var/lib/prowlarr" =
      {
        device = "/dev/disk/by-uuid/c3e8e9e9-17a4-4e01-9f7d-3b80f9c3790f";
        fsType = "btrfs";
        options = [ "compress=zstd" "subvol=var/lib/prowlarr" ];
      };

    "/var/lib/transmission/.incomplete" =
      {
        device = "/dev/disk/by-uuid/c3e8e9e9-17a4-4e01-9f7d-3b80f9c3790f";
        fsType = "btrfs";
        options = [ "nodatacow" "subvol=torrent-incomplete" ];
      };

    "/var/lib/transmission/Downloads" =
      {
        device = "/dev/disk/by-uuid/c3e8e9e9-17a4-4e01-9f7d-3b80f9c3790f";
        fsType = "btrfs";
        options = [ "compress=zstd" "subvol=torrent-complete" ];
      };

    "/var/log" =
      {
        device = "/dev/disk/by-uuid/9adf901b-b846-48b7-ad73-51f6241b4a63";
        fsType = "btrfs";
        options = [ "subvol=var/log" "compress=zstd" "noatime" ];
      };

    "/var/cache" =
      {
        device = "/dev/disk/by-uuid/9adf901b-b846-48b7-ad73-51f6241b4a63";
        fsType = "btrfs";
        options = [ "subvol=var/cache" "noatime" ];
      };

    "/nix" =
      {
        device = "/dev/disk/by-uuid/9adf901b-b846-48b7-ad73-51f6241b4a63";
        fsType = "btrfs";
        options = [ "subvol=nix" "compress=zstd" "noatime" ];
      };

    "/home" =
      {
        device = "/dev/disk/by-uuid/9adf901b-b846-48b7-ad73-51f6241b4a63";
        fsType = "btrfs";
        options = [ "subvol=home" "compress=zstd" "noatime" ];
      };

    "/swap" =
      {
        device = "/dev/disk/by-uuid/9adf901b-b846-48b7-ad73-51f6241b4a63";
        fsType = "btrfs";
        options = [ "subvol=swap" "noatime" ];
      };

    "/boot" =
      {
        device = "/dev/disk/by-uuid/63E9-9AD5";
        fsType = "vfat";
      };
  };

  swapDevices = [{ device = "/swap/swapfile"; }];
  boot.tmp.useTmpfs = true;

  nixpkgs.hostPlatform = "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = true;
}
