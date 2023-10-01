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

  # Vagrant
  services.nfs.server.enable = true;

  networking.firewall.extraCommands = ''
    ip46tables -I INPUT 1 -i vboxnet+ -p tcp -m tcp --dport 2049 -j ACCEPT
  '';

  # Add firewall exception for libvirt provider when using NFSv4
  networking.firewall.interfaces."virbr1" = {
    allowedTCPPorts = [ 2049 ];
    allowedUDPPorts = [ 2049 ];
  };
}

# Windows VM optimization options
#
#   <vcpu placement="static">8</vcpu>
#   <cputune>
#     <vcpupin vcpu="0" cpuset="8"/>
#     <vcpupin vcpu="1" cpuset="9"/>
#     <vcpupin vcpu="2" cpuset="10"/>
#     <vcpupin vcpu="3" cpuset="11"/>
#     <vcpupin vcpu="4" cpuset="12"/>
#     <vcpupin vcpu="5" cpuset="13"/>
#     <vcpupin vcpu="6" cpuset="14"/>
#     <vcpupin vcpu="7" cpuset="15"/>
#     <emulatorpin cpuset="0-1"/>
#   </cputune>
#   <features>
#     <acpi/>
#     <apic/>
#     <hyperv mode="custom">
#       <relaxed state="on"/>
#       <vapic state="on"/>
#       <spinlocks state="on" retries="8191"/>
#       <vpindex state="on"/>
#       <runtime state="on"/>
#       <synic state="on"/>
#       <stimer state="on"/>
#       <vendor_id state="on" value="KVM Hv"/>
#       <tlbflush state="on"/>
#       <ipi state="on"/>
#     </hyperv>
#     <kvm>
#       <hidden state="on"/>
#     </kvm>
#     <vmport state="off"/>
#   </features>
#   <cpu mode="host-passthrough" check="partial" migratable="on">
#     <topology sockets="1" dies="1" cores="4" threads="2"/>
#     <feature policy="require" name="topoext"/>
#     <feature policy="disable" name="hypervisor"/>
#   </cpu>
#   <clock offset="localtime">
#     <timer name="rtc" tickpolicy="catchup"/>
#     <timer name="pit" tickpolicy="delay"/>
#     <timer name="hpet" present="no"/>
#     <timer name="hypervclock" present="yes"/>
#   </clock>
