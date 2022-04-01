{ pkgs, ... }:

{
  programs.mpv = {
    enable = true;

    config = {
      # hwdec = "auto-safe";
      scale = "ewa_lanczossharp";
      cscale = "ewa_lanczossharp";
      tscale = "oversample";
      interpolation = true;
      gpu-context = "wayland";
      video-sync = "display-resample";
    };

    defaultProfiles = [ "gpu-hq" ];
    scripts = [ pkgs.mpvScripts.mpris ];
  };
}
