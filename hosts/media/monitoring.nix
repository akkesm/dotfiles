{ config, ... }:

let
  grafanaServerCfg = config.services.grafana.settings.server;
in
{
  networking.firewall.allowedTCPPorts = [ 3000 9090 ];

  services = {
    grafana = {
      enable = true;

      provision = {
        enable = true;

        datasources.settings.datasources = [{
          name = "Prometheus";
          type = "prometheus";
          url = "http://localhost:${toString config.services.prometheus.port}/prometheus";

          prometheusType = "Prometheus";
        }];
      };

      settings = {
        server = {
          enable_gzip = true;
          http_addr = "127.0.0.1";
          http_port = 3000;
          root_url = "https://media.fritz.box/grafana";
          serve_from_sub_path = true;
        };
      };
    };

    nginx.virtualHosts."media.fritz.box".locations = {
      "^~ /grafana" = {
        proxyPass = "http://${grafanaServerCfg.http_addr}:${toString grafanaServerCfg.http_port}";
        proxyWebsockets = true;
      };

      "^~ /prometheus" = {
        proxyPass = "http://127.0.0.1:${toString config.services.prometheus.port}";
      };
    };

    prometheus = {
      enable = true;
      enableReload = true;

      exporters = {
        node = {
          enable = true;

          enabledCollectors = [
            "ethtool"
            "mountstats"
            "sysctl"
            "systemd"
            "tcpstat"
          ];
        };
      };

      port = 9090;

      scrapeConfigs = [{
          job_name = "node";

          static_configs = [{
            targets = [ "localhost:${toString config.services.prometheus.exporters.node.port}" ];
          }];
        }];

      webExternalUrl = "http://media.fritz.box/prometheus";
    };
  };
}
