{ config, pkgs, ... }:

{
  environment.systemPackages = (with config.boot.kernelPackages; [
    bpftrace
    perf
  ]) ++ (with pkgs; [
    bpytop
    dig
    duf
    glances
    nettools
    libva-utils
    lshw
    lsof
    nmap
    pciutils
    sysstat
    tcpdump
    usbutils
    whois
  ]);

  programs = {
    atop = {
      enable = true;
      setuidWrapper.enable = true;
    };

    bcc.enable = true;
    mtr.enable = true;
    sysdig.enable = true;
    traceroute.enable = true;
    wireshark.enable = true;
    zmap.enable = true;
  };
}
