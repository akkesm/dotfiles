{ config, ... }:

{
  services.cachix-agent = {
    enable = true;
    credentialsFile = config.sops.secrets.agent-token.path;
  };

  sops.secrets.agent-token = {
    format = "yaml";
    sopsFile = ./secrets/cachix.yaml;
  };
}
