{ config, pkgs, ... }:

{
  home.packages = [ pkgs.ciscoPacketTracer8 ];
  programs.zsh.shellAliases.packettracer8 = "QT_QPA_PLATFORM=xcb packettracer8";
}
