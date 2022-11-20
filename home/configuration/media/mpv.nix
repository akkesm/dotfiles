{ pkgs, ... }:

{
  programs.mpv = {
    enable = true;

    defaultProfiles = [
      "gpu-hq"
      "wayland-pipewire"
    ];

    profiles = rec {
      hq = {
        scale = "ewa_lanczossharp";
        cscale = "ewa_lanczossharp";
        tscale = "oversample";
        interpolation = true;
        video-sync = "display-resample";
      };

      wayland-pipewire = hq // {
        hwdec = "vaapi";
        gpu-context = "wayland";
        ao = "pipewire,";
        vo = "dmabuf-wayland";
      };
    };

    scripts = with pkgs.mpvScripts; [
      mpris
      thumbnail
      youtube-quality
    ];
  };
}
