{ config, pkgs, ... }:

{
  networking.firewall.allowedUDPPorts = [ config.systemd.network.netdevs."10-wg0".wireguardConfig.ListenPort ];

  systemd.network = {
    enable = true;

    netdevs = {
      "10-wg0" = {
        netdevConfig = {
          Kind = "wireguard";
          Name = "wg0";
        };

        wireguardConfig = {
          PrivateKeyFile = config.sops.secrets.vpn-key.path;
          ListenPort = 9918;
        };

        wireguardPeers = [{
          PublicKey = "J4XVdtoBVc/EoI2Yk673Oes97WMnQSH5KfamZNjtM2s=";
          AllowedIPs = [ "0.0.0.0/0" ];
          Endpoint = "185.183.34.149:51820";
        }];
      };
    };

    networks.wg0 = {
      matchConfig.Name = "wg0";
      address = [ "10.2.0.2/32" ];
      DHCP = "no";
      dns = [ "10.2.0.1" ];
      networkConfig.IPv6AcceptRA = false;
    };
  };

  sops.secrets.vpn-key = {
    format = "yaml";
    sopsFile = ./secrets/vpn.yaml;
    owner = "systemd-network";
  };
}

