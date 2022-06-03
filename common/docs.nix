{ pkgs, ... }:

{
  documentation = {
    enable = true;
    dev.enable = true;

    man = {
      generateCaches = true;
      man-db.enable = false;
      mandoc.enable = true;
    };

    nixos.enable = true;
  };

  environment.systemPackages = with pkgs; [
    man-pages
    manix
    tldr
  ];
}
