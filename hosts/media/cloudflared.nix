{ config, pkgs, ... }:

{
  networking.firewall = {
    allowedTCPPorts = [ 7844 ];
    allowedUDPPorts = [ 7844 ];
  };

  security.acme =
    let
      domain1 = "figure4.dev";
    in
    {
      acceptTerms = true;

      certs."${domain1}" = {
        extraDomainNames = [
          "ente.${domain1}"
          "museum.${domain1}"
        ];

        postRun = ''
          # set permission on dir
          ${pkgs.acl}/bin/setfacl -m \
          u:nginx:rx,u:turnserver:rx,u:prosody:rx,u:dovecot2:rx,u:postfix:rx \
          ${config.security.acme.certs."${domain1}".directory}

          # set permission on key file
          ${pkgs.acl}/bin/setfacl -m \
          u:nginx:r,u:turnserver:r,u:prosody:r,u:dovecot2:r,u:postfix:r \
          ${config.security.acme.certs."${domain1}".directory}/*.pem
        '';
      };

      defaults = {
        credentialFiles = {
          CF_DNS_API_TOKEN_FILE = config.sops.secrets.cloudflare-dns-api-token.path;
          CF_ZONE_API_TOKEN_FILE = config.sops.secrets.cloudflare-zone-api-token.path;
        };

        dnsProvider = "cloudflare";
        dnsResolver = "cloudflare";
        email = "alessandro.barenghi@tuta.io";
        group = config.services.nginx.group;

        reloadServices = [ "nginx" ];
      };
    };

  services = {
    cloudflared = {
      enable = true;
      certificateFile = config.sops.secrets.cloudflared-cert.path;

      tunnels."4789238c-c935-4489-9af6-bacd7f45b2b9" = {
        credentialsFile = config.sops.secrets.cloudflared-credentials-frejus.path;
        default = "http_status:404";
      };
    };

    openssh.settings.Macs = [
      # Current defaults:
      "hmac-sha2-512-etm@openssh.com"
      "hmac-sha2-256-etm@openssh.com"
      "umac-128-etm@openssh.com"
      # Added:
      "hmac-sha2-256"
    ];
  };

  sops.secrets = {
    cloudflare-dns-api-token = {
      format = "yaml";
      sopsFile = ./secrets/cloudflare-api-tokens.yaml;
    };

    cloudflare-zone-api-token = {
      format = "yaml";
      sopsFile = ./secrets/cloudflare-api-tokens.yaml;
    };

    cloudflared-cert = {
      format = "binary";
      sopsFile = ./secrets/cloudflared/cert.pem;
    };

    cloudflared-credentials-frejus = {
      format = "binary";
      sopsFile = ./secrets/cloudflared/4789238c-c935-4489-9af6-bacd7f45b2b9.json;
    };
  };
}

