{ config, lib, ... }:

{
  environment.persistence."/persist".files = [
    "/etc/machine-id"
    "/etc/ssh/ssh_host_ed25519_key"
    "/etc/ssh/ssh_host_ed25519_key.pub"
    "/etc/ssh/ssh_host_rsa_key"
    "/etc/ssh/ssh_host_rsa_key.pub"
  ];

  boot.initrd.postDeviceCommands = lib.mkBefore ''
    mkdir -p /mnt

    mount -o subvol=/ /dev/mapper/nixos-enc /mnt

    btrfs subvolume list -o /mnt/root |
    cut -f 9 -d ' ' |
    while read subvolume; do
      btrfs subvolume delete "/mnt/$subvolume" &&
      echo 'deleting /$subvolume subvolume...'
    done &&
    btrfs subvolume delete /mnt/root &&
    echo 'deleting /root subvolume...'

    btrfs subvolume snapshot /mnt/root-blank /mnt/root &&
    echo 'restoring blank /root subvolume...'

    umount /mnt
  '';
}
