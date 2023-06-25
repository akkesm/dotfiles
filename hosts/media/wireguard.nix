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
          ListenPort = 51820;
          PrivateKeyFile = "/run/keys/wireguard-privkey.key";
        };

        wireguardPeers = [{
          wireguardPeerConfig = {
            AllowedIPs = [ "192.168.178.1/32" ];
            PublicKey = "OhApdFoOYnKesRVpnYRqwk3pdM247j8PPVH5K7aIKX0=";
            PresharedKeyFile = "/run/keys/wg-preshared.key";
          };
        }];
      };
    };
  };
}
