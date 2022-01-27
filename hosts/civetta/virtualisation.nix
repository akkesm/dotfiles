{ config, pkgs, ... }:

{
  boot.initrd.kernelModules = [ "kvm-amd" ];
  
  # http://bkanuka.com/posts/windows-10-libvirt/
  virtualisation.libvirtd = { # Add users to "libvirtd" group
    enable = true;
  };

  environment.systemPackages = [ pkgs.virt-manager ];
}
