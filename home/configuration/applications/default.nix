{ config, pkgs, ... }:

{
  imports = [
    ./browsers.nix
    ./chat.nix
    ./documents.nix
    ./games.nix
  ];

  home.packages = with pkgs; [
    ciscoPacketTracer8
    dolphin
    gimp
    lbry
    # openclonk
    # passky
  ];
  
  programs.zsh.shellAliases.packettracer8 = "QT_QPA_PLATFORM=xcb packettracer8";
}
