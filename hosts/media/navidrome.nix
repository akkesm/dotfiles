{ config, pkgs, ... }:

{
  services.navidrome = {
    enable = true;

    settings = {
      MusicFolder = "/var/music";
      DataFolder = "/var/lib/navidrome";
      ScanSchedule = "0";
      Address = "192.168.178.2";
      "LastFM.Language" = "it";
      "ListenBrainz.Enabled" = false;
      EnableStarRating = false;
    };
  };
}
