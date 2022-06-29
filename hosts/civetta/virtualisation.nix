{ pkgs, ... }:

{
  boot = {
    # https://nixos.wiki/wiki/OSX-KVM
    extraModprobeConfig = ''
      options kvm_amd nested=1
      options kvm_amd emulate_invalid_guest_state=0
      options kvm ignore_msrs=1
    '';

    initrd.kernelModules = [ "kvm-amd" ];
  };

  # http://bkanuka.com/posts/windows-10-libvirt/
  # https://kevinlocke.name/bits/2021/12/10/windows-11-guest-virtio-libvirt/
  virtualisation.libvirtd = {
    # Add users to "libvirtd" group
    enable = true;
    qemu.swtpm.enable = true;
  };

  environment.systemPackages = [ pkgs.virt-manager ];
}
