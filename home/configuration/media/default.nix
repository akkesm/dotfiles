{ config, pkgs, ... }:

{
  imports = [ ./easyeffects.nix ];

  programs = {
    beets = {
      enable = true;

      package = pkgs.beets.override {
        enableAlternatives = true;
        enableExtraFiles = true;
      };

      settings = {
        library = "${config.xdg.dataHome}/beets/library.db";
        directory = config.xdg.userDirs.music;
        plugins = [
          "deezer"
          "edit"
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
          incremental_skip_later = "yes";
        };

        musicbrainz.extratags = [ "year" ];

        match = {
          preferred.original_year = "yes";
          ignored = [ "track_length" ];
        };

        paths.default = "$albumartist/$year-$album%aunique{}/$track-$title";
      };
    };

    mpv = {
      enable = true;

      config = {
        # hwdec = "auto-safe";
        vo = "gpu";
        window-maximized = true;
      };
    };

    ncmpcpp = {
      enable = true;

      settings = {
        ncmpcpp_directory = "${config.xdg.dataHome}/ncmpcpp";
        lyrics_directory = "${config.xdg.dataHome}/ncmpcpp/lyrics";
        mpd_host = config.services.mpd.network.listenAddress;
        mpd_port = config.services.mpd.network.port;
        mpd_crossfade_time = 0;
        message_delay_time = 3;
        playlist_show_remaining_time = "yes";
        browser_display_mode = "columns";
        progressbar_look = "―›";
        cyclic_scrolling = "yes";
        display_bitrate = "yes";
        search_engine_default_search_mode = 2;
        external_editor = "nvim";
      };
    };
  };

  services = {
    mpd = {
      enable = true;
      dataDir = "${config.xdg.dataHome}/mpd";
      extraConfig = ''
        audio_output {
          type "pipewire"
          name "PipeWire Sound Server"
        }
      '';
      musicDirectory = "${config.home.homeDirectory}/Music";
      network.startWhenNeeded = true;
    };

    mpdris2.enable = true;
  };
}
