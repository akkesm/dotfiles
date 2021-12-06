{ config, pkgs, ... }:

{
  documentation = {
    enable = true;
    dev.enable = true;
    man.generateCaches = true;
  };

  environment.systemPackages = with pkgs; [
    man-pages
    manix
    tldr
  ];
}
