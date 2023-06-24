{ config, pkgs, ... }:

{
  networking = {
    dhcpcd.enable = false;
    firewall = {
      package = pkgs.iptables-nftables-compat;
      allowPing = false;
    };

    hosts = {
      "::1" = [ "localhost" ];
      "192.168.178.1" = [ "lanlocalhost" "router" ];
    };

    wireless = {
      enable = true;
      userControlled.enable = true;
    };
  };

  services.resolved = {
    enable = true;

    extraConfig = ''
      DNSOverTLS=opportunistic
    '';

    fallbackDns = [
      "9.9.9.9#dns.quad9.net"
      "149.112.112.112#dns.quad9.net"
      "2620:fe::fe#dns.quad9.net"
      "2620:fe::9#dns.quad9.net"

      "84.200.69.80#resolver1.dns.watch"
      "84.200.70.40#resolver2.dns.watch"
      "2001:1608:10:25::1c04:b12f#resolver1.dns.watch"
      "2001:1608:10:25::9249:d69b#resolver2.dns.watch"

      "45.91.92.121#dot-ch.blahdns.com"
      "2a0e:dc0:6:23::2#dot-ch.blahdns.com"
      "78.46.244.143#dot-de.blahdns.com"
      "2a01:4f8:c17:ec67::1#dot-de.blahdns.com"
    ];
  };
}
