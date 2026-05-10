{ config, lib, ... }:

{
  networking.firewall = {
    allowedTCPPortRanges = [
      {
        from = 3000;
        to = 3006;
      }
      {
        from = 3200;
        to = 3201;
      }
    ];

    allowedTCPPorts = [ 8080 ];

    allowedUDPPortRanges = [
      {
        from = 3000;
        to = 3006;
      }
      {
        from = 3200;
        to = 3201;
      }
    ];

    allowedUDPPorts = [ 8080 ];
  };

  services = {
    cloudflared.tunnels."4789238c-c935-4489-9af6-bacd7f45b2b9".ingress = {
      "figure4.dev" = "http://${config.services.ente.web.domains.photos}";
      "ente.figure4.dev" = "http://${config.services.ente.web.domains.photos}";
      "museum.figure4.dev" = "http://${config.services.ente.api.domain}";
    };

    ente = {
      api = {
        enable = true;
        enableLocalDB = true;
        domain = "localhost:8080";

        settings = {
          log-file = "/var/log/ente/museum.log";

          s3 = {
            are_local_buckets = true;
            use_path_style_urls = true;

            b2-eu-cen = {
              key._secret = config.sops.secrets.minio-root-user.path;
              secret._secret = config.sops.secrets.minio-root-password.path;
              endpoint = "localhost${config.services.minio.listenAddress}";
              region = config.services.minio.region;
            };
          };

          key = {
            encryption._secret = config.sops.secrets.ente-key-encryption.path;
            hash._secret = config.sops.secrets.ente-key-hash.path;
          };

          jwt.secret._secret = config.sops.secrets.ente-jwt-secret.path;

          smtp = {
            host = "mail-eu.smtp2go.com";
            port = 465;
            username._secret = config.sops.secrets.ente-smtp-user.path;
            password._secret = config.sops.secrets.ente-smtp-password.path;
            email = "ente-noreply@figure4.dev";
            sender-name = "Ente NoReply";
            encryption = "ssl";
          };

          internal = {
            admins = [ "1580559962386438" ];
          };
        };
      };

      web = {
        enable = true;

        domains = {
          accounts = "localhost:3001";
          albums = "localhost:3002";
          api = lib.mkForce "museum.figure4.dev";
          cast = "localhost:3004";
          photos = "localhost:3000";
        };
      };
    };

    minio = {
      enable = true;
      consoleAddress = ":3201";
      listenAddress = ":3200";
      region = "eu-south-1";
      rootCredentialsFile = config.sops.templates."minio.env".path;
    };

    nginx.virtualHosts = {
      "localhost:3000" = {
        forceSSL = lib.mkForce false;

        listen = [
          {
            addr = "0.0.0.0";
            port = 3000;
          }
          {
            addr = "[::0]";
            port = 3000;
          }
        ];
      };

      "localhost:3001" = {
        forceSSL = lib.mkForce false;

        listen = [
          {
            addr = "0.0.0.0";
            port = 3001;
          }
          {
            addr = "[::0]";
            port = 3001;
          }
        ];

      };

      "localhost:3004" = {
        forceSSL = lib.mkForce false;

        listen = [
          {
            addr = "0.0.0.0";
            port = 3004;
          }
          {
            addr = "[::0]";
            port = 3004;
          }
        ];
      };

      "ente.figure4.dev" = {
        enableACME = true;
        acmeRoot = null;
        forceSSL = true;

        locations = {
          "/" = {
            return = "301 /photos";
          };

          "/photos" = {
            proxyPass = "http://localhost:3000";
          };

          "/accounts" = {
            proxyPass = "http://localhost:3001";
          };

          "/albums" = {
            proxyPass = "http://localhost:3002";
          };

          "/cast" = {
            proxyPass = "http://localhost:3004";
          };
        };
      };

      "museum.figure4.dev" = {
        enableACME = true;
        acmeRoot = null;
        forceSSL = true;

        locations."/" = {
          proxyPass = "http://localhost:8080";
        };
      };

      "media.fritz.box".locations = {
        "/ente" = {
          return = "301 /ente/photos";
        };

        "/ente/photos" = {
          proxyPass = "http://localhost:3000";
        };

        "/ente/accounts" = {
          proxyPass = "http://localhost:3001";
        };

        "/ente/albums" = {
          proxyPass = "http://localhost:3002";
        };

        "/ente/cast" = {
          proxyPass = "http://localhost:3004";
        };
      };
    };
  };

  sops = {
    secrets = {
      ente-key-encryption = {
        format = "yaml";
        owner = config.users.users."${config.services.ente.api.user}".name;
        sopsFile = ./secrets/ente.yaml;
      };

      ente-key-hash = {
        format = "yaml";
        owner = config.users.users."${config.services.ente.api.user}".name;
        sopsFile = ./secrets/ente.yaml;
      };

      ente-jwt-secret = {
        format = "yaml";
        owner = config.users.users."${config.services.ente.api.user}".name;
        sopsFile = ./secrets/ente.yaml;
      };

      ente-smtp-user = {
        format = "yaml";
        owner = config.users.users."${config.services.ente.api.user}".name;
        sopsFile = ./secrets/ente.yaml;
      };

      ente-smtp-password = {
        format = "yaml";
        owner = config.users.users."${config.services.ente.api.user}".name;
        sopsFile = ./secrets/ente.yaml;
      };

      minio-root-user = {
        format = "yaml";
        mode = "0440";
        owner = config.users.users.minio.name;
        group = config.users.users.minio.group;
        sopsFile = ./secrets/minio.yaml;
      };

      minio-root-password = {
        format = "yaml";
        mode = "0440";
        owner = config.users.users.minio.name;
        group = config.users.users.minio.group;
        sopsFile = ./secrets/minio.yaml;
      };
    };

    templates."minio.env".content = ''
      MINIO_ROOT_USER=${config.sops.placeholder.minio-root-user}
      MINIO_ROOT_PASSWORD=${config.sops.placeholder.minio-root-password}
    '';
  };

  systemd = {
    services.ente.serviceConfig.ReadWritePaths = [ "/var/log/ente" ];
    tmpfiles.rules = [ "d /var/log/ente 0750 ${config.users.users.${config.services.ente.api.user}.name} ${config.users.users."${config.services.ente.api.user}".group} - -" ];
  };

  users.users."${config.services.ente.api.user}".extraGroups = [ "minio" ];
}

