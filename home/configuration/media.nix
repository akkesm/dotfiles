{ config, ... }:

{
  programs = {
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
        message_delay_time = 3;
        volume_change_step = 2;
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
