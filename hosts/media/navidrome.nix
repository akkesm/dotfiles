{ config, ... }:

{
  services = {
    navidrome = {
      enable = true;
      openFirewall = true;

      settings = {
        MusicFolder = "/data/music";
        DataFolder = "/var/lib/navidrome";
        BaseUrl = "/navidrome";

        DefaultLanguage = "it";
        EnableStarRating = false;
        "LastFM.Enabled" = false;
        "LastFM.Language" = "it";
        "ListenBrainz.Enabled" = false;
        "Prometheus.Enabled" = true;
      };
    };

    nginx.virtualHosts."media.fritz.box".locations."^~ /navidrome" = {
      proxyPass = "http://localhost:${builtins.toString config.services.navidrome.settings.Port}";
    };
  };
}

