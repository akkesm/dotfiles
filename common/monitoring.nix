{ config, pkgs, ... }:

{
  environment.systemPackages = (with config.boot.kernelPackages; [
    bpftrace
    # perf
  ]) ++ (with pkgs; [
    bottom
    dig
    duf
    libva-utils
    lshw
    lsof
    nettools
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
    # sysdig.enable = true;
    traceroute.enable = true;
    trippy.enable = true;
    wireshark.enable = true;
    zmap.enable = true;
  };
}
