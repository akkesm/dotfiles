{ ... }:

{
  services = {
    traefik = {
      enable = true;
      dynamicConfigOptions = {
        http = {
          middlewares = {
            redirect-to-https.redirectScheme = {
              permanent = true;
              scheme = "https";

              hsts-header.headers.customResponseHeaders.Strict-Transport-Security = "max-age=63072000";
            };

            routers = {
              vaultwarden-ui-http = {
                entrypoints = "web";
                rule = "Host(`vaultwarden.local`)";
                middlewares = [ "redirect-to-https" "hsts-header" ];
                service = "vaultwarden-ui";
              };

              vaultwarden-ui-https = {
                entrypoints = "websecure";
                rule = "Host(`vaultwarden.local`)";
                middlewares = [ "hsts-header" ];
                service = "vaultwarden-ui";
                tls.options = "modern";
              };

              vaultwarden-websocket-http = {
                entrypoints = "web";
                rule = "Host(`vaultwarden.local`) && Path(`/notifications/hub`)";
                middlewares = [ "redirect-to-https" "hsts-header" ];
                service = "vaultwarden-websocket";

                vaultwarden-websocket-https = {
                  entrypoints = "websecure";
                  rule = "Host(`vaultwarden.local`) && Path(`/notifications/hub`)";
                  middlewares = [ "hsts-header" ];
                  service = "vaultwarden-websocket";
                  tls.options = "modern";
                };
              };
            };

            services = {
              vaultwarden-ui.loadbalancer.server.port = 80;
              vaultwarden-websocket.loadbalancer.server.port = 3012;
            };

            tls = {
              certificates = {
                certFile = "/path/to/signed_cert_plus_intermediates";
                keyFile = "/path/to/private_key";
              };

              options.modern.minVersion = "VersionTLS13";
            };
          };
        };
      };
      staticConfigOptions = {
        entryPoints = {
          web.address = ":80";
          websecure.address = ":443";
        };
      };
    };

    vaultwarden = {
      enable = true;
      dbBackend = "postgresql";
      config = {
        DOMAIN = "https://vaultwarden.media.local";
        SIGNUPS_ALLOWED = false;
        WEBSOCKET_ENABLED = true;
        DATA_FOLDER="/var/vaultwarden/data";
      };
    };
  };
}
