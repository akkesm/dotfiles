{ config, lib, pkgs, ... }:

{
  networking = {
    enableIPv6 = false; # FIXME bugs eduroam
    dhcpcd.enable = false;
    useDHCP = false;

    interfaces = {
      # eno1.useDHCP = true;
      wlp1s0.useDHCP = true;
    };

    firewall = {
      enable = true;
      package = pkgs.iptables-nftables-compat;
      allowPing = false;

      # KDE Connect
      allowedTCPPortRanges = [ { from = 1714; to = 1764; } ];
      allowedUDPPortRanges = [ { from = 1714; to = 1764; } ];

      logRefusedConnections = true;
      logRefusedPackets = false;
      logRefusedUnicastsOnly = true;
    };

    hostName = "civetta";

    hosts = {
      "127.0.0.1" = [ "localhost" "localhost.localdomain" ];
      "192.168.178.1" = [ "fritz.box" "lanlocalhost" "router" ];
    };

    useNetworkd = true;
    # tempAddresses = "enabled"; # IPv6 only

    wireless = {
      enable = true;
      environmentFile = config.sops.secrets.environmentFile.path;
      interfaces = [ "wlp1s0" ];

      networks = {
        "FRITZ!Box 7590 FC" = {
          authProtocols = [ "WPA-PSK" ];
          psk = "@PSK_FRITZBOX@";
        };

        "coldspot" = {
          authProtocols = [ "WPA-PSK" ];
          hidden = true;
          psk = "@PSK_COLDSPOT@";
        };

        "eduroam" = {
          authProtocols = [ "WPA-EAP" ];
          auth = ''
            pairwise=CCMP
            group=CCMP TKIP
            eap=TLS
            ca_cert="${config.sops.secrets.polimi-cert.path}"
            identity="@IDENTITY_POLIMI@@polimi.it"
            altsubject_match="DNS:wifi.polimi.it"
            private_key_passwd="@PSK_POLIMI@"
            private_key="${config.sops.secrets.polimi-keyFile.path}"
          '';
        };

        "polimi-protected" = {
          authProtocols = [ "WPA-EAP" ];
          auth = ''
            pairwise=CCMP
            group=CCMP TKIP
            eap=TLS
            ca_cert="${config.sops.secrets.polimi-cert.path}"
            identity="@IDENTITY_POLIMI@@polimi.it"
            altsubject_match="DNS:wifi.polimi.it"
            private_key_passwd="@PSK_POLIMI@"
            private_key="${config.sops.secrets.polimi-keyFile.path}"
          '';
        };
      };

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

  sops.secrets = {
    environmentFile = {
      format = "binary";
      sopsFile = ./secrets/networks/environmentFile;
    };

    polimi-cert = {
      format = "binary";
      sopsFile = ./secrets/networks/polimi-cert/ca.pem;
    };

    polimi-keyFile = {
      format = "binary";
      sopsFile = ./secrets/networks/polimi-cert/user.p12;
    };
  };
}
