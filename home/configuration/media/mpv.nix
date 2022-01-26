{ config, ... }:

{
  programs.mpv = {
    enable = true;

    config = {
      # hwdec = "auto-safe";
      vo = "gpu";
      window-maximized = true;
    };
  };
}
