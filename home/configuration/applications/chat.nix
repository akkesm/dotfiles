{ pkgs, ... }:

{
  home.packages = with pkgs; [
    discord-ptb
    element-desktop
    tdesktop
  ];
}
