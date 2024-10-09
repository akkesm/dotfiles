{ lib, config, ... }:

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
      secretsFile = config.sops.secrets.secretsFile.path;

      extraConfig = ''
        pmf=1
      '';

      fallbackToWPA2 = false;
      interfaces = [ "wlp1s0" ];

      networks = {
        "FRITZ!Box 7590 ZT" = {
          authProtocols = [ "SAE" ];

          extraConfig = ''
            ieee80211w=2
          '';

          pskRaw = "ext:psk_fritzbox";
        };

        "coldspot" = {
          authProtocols = [ "WPA-PSK" ];
          hidden = true;
          pskRaw = "ext:psk_coldspot";
        };

        "eduroam" = {
          authProtocols = [ "WPA-EAP" ];
          auth = ''
            pairwise=CCMP
            group=CCMP TKIP
            eap=TLS
            ca_cert="${config.sops.secrets."polimi/cert".path}"
            identity="@POLIMI_IDENTITY@@polimi.it"
            altsubject_match="DNS:wifi.polimi.it"
            private_key_passwd="ext:psk_polimi"
            private_key="${config.sops.secrets."polimi/keyFile".path}"
          '';
        };

        "polimi-protected" = {
          authProtocols = [ "WPA-EAP" ];
          auth = ''
            pairwise=CCMP
            group=CCMP TKIP
            eap=TLS
            ca_cert="${config.sops.secrets."polimi/cert".path}"
            identity="@POLIMI_IDENTITY@@polimi.it"
            altsubject_match="DNS:wifi.polimi.it"
            private_key_passwd="ext:psk_polimi"
            private_key="${config.sops.secrets."polimi/keyFile".path}"
          '';
        };

        "Gemini" = {
          authProtocols = [ "WPA-PSK" ];
          pskRaw = "ext:psk_gemini";
        };
      };
    };
  };

  systemd.services."wpa_supplicant-wlp1s0".serviceConfig.EnvironmentFile = config.sops.templates."wpa_supplicant.env".path;

  sops = {
    secrets = {
      secretsFile = {
        format = "binary";
        sopsFile = ./secrets/networks/secretsFile;
      };

      "polimi/cert" = {
        format = "binary";
        sopsFile = ./secrets/networks/polimi-cert/ca.pem;
      };

      "polimi/keyFile" = {
        format = "binary";
        sopsFile = ./secrets/networks/polimi-cert/user.p12;
      };

      "polimi/identity" = {
        format = "yaml";
        sopsFile = ./secrets/networks/polimi-cert/identity.yaml;
      };
    };

    templates."wpa_supplicant.env".content = ''
      POLIMI_IDENTITY=${config.sops.placeholder."polimi/identity"}
    '';
  };
}
