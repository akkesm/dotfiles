{ ... }:

{
  services = {
    navidrome = {
      enable = true;

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
        proxyPass = "http://127.0.0.1:4533";
      };
    };
  }
