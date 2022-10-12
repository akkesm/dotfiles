{ ... }:

{
  imports = [
    ./beets.nix
    # ./easyeffects.nix
    ./mpd.nix
    ./mpv.nix
  ];

  services = {
    mpris-proxy.enable = true;
    playerctld.enable = true;
  };
}
