{ pkgs, ... }:

{
  home = {
    packages = [ pkgs.ciscoPacketTracer8 ];
    shellAliases.packettracer8 = "QT_QPA_PLATFORM=xcb packettracer8";
  };
}
