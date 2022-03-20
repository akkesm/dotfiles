{ config, pkgs, ... }:

{
  programs.beets = {
    enable = true;

    package = pkgs.beets.override {
      enableAlternatives = true;
      enableExtraFiles = true;
    };

    settings = {
      library = "${config.xdg.dataHome}/beets/library.db";
      directory = config.xdg.userDirs.music;
      plugins = [
        "convert"
        "deezer"
        "edit"
        "fetchart"
        "fuzzy"
        "missing"
        "mpdupdate"
        "spotify"
      ];

      ignore = [
        ".*"
        "*~"
        "System Volume Information"
        "lost+found"
        "*.m3u"
        "*.txt"
      ];

      format_album = "$year - $albumartist - $album";
      sort_album = "albumartist+ year+";

      import = {
        reflink = "auto";
        incremental = "yes";
        incremental_skip_later = "yes";
      };

      musicbrainz = {
        extratags = [ "year" ];
        genres = "yes";
      };

      match = {
        preferred.original_year = "yes";
        ignored = [ "track_length" ];
        max-rec.year = "low";
      };

      paths.default = "$albumartist/$year-$album%aunique{}/$track-$title";
    };
  };
}
