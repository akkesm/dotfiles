{ config, pkgs, ... }:

{
  boot = {
    kernelModules = [ "tcp_veno" ];
    kernel.sysctl."net.ipv4.tcp_congestion_control" = "veno";
  };

  networking = {
    hostName = "civetta";
    interfaces.wlp1s0.useDHCP = true;
    useDHCP = false;
    useNetworkd = true;

    wireless = {
      environmentFile = config.sops.secrets.environmentFile.path;
      interfaces = [ "wlp1s0" ];

      networks = {
        "FRITZ!Box 7590 ZT" = {
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
        "Gemini" = {
          authProtocols = [ "WPA-PSK" ];
          psk = "@PSK_GEMINI@";
        };
      };
    };
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
