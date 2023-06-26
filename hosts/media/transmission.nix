{ ... }:

{
  services = {
    lidarr = {
      enable = true;
      group = "media";
      dataDir = "/var/lib/lidarr";
      openFirewall = true;
    };

    prowlarr = {
      enable = true;
      openFirewall = true;
    };

    transmission = {
      enable = true;
      group = "media";
      openPeerPorts = true;
      openRPCPort = true;

      settings = {
        incomplete-dir-enabled = true;
        trash-original-torrent-files = true;

        cache-size-mb = 128;

        download-queue-size = 10;
        seed-queue-enabled = true;
        seed-queue-size = 20;

        rpc-bind-address = "0.0.0.0";
        rpc-whitelist = "127.0.0.1,::1,192.168.178.*";
        rpc-host-whitelist = "*.fritz.box";
      };
    };

    nginx = {
      virtualHosts = {
        "media.fritz.box" = {
          locations = {
            "/lidarr" = {
              proxyPass = "http://127.0.0.1:8686";

              extraConfig = ''
                proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
                proxy_set_header X-Forwarded-Host $host;
                proxy_set_header X-Forwarded-Proto $scheme;
                proxy_set_header Upgrade $http_upgrade;
                proxy_set_header Connection $http_connection;
              '';
            };
            "^~ /lidarr/api" = {
              proxyPass = "http://127.0.0.1:8686";

              extraConfig = ''
                auth_basic off;
              '';
            };

            "/prowlarr" = {
              proxyPass = "http://127.0.0.1:9696";

              extraConfig = ''
                proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
                proxy_set_header X-Forwarded-Host $host;
                proxy_set_header X-Forwarded-Proto $scheme;
                proxy_set_header Upgrade $http_upgrade;
                proxy_set_header Connection $http_connection;
              '';
            };
            "^~ /prowlarr(/[0-9]+)?/api" = {
              proxyPass = "http://127.0.0.1:9696";

              extraConfig = ''
                auth_basic off;
              '';
            };

            "^~ /transmission" = {
              proxyPass = "http://127.0.0.1:9091/transmission";
            };
          };
        };
      };
    };
  };

  users.groups.media = { };
}
