{ config, pkgs, ... }:

{
  imports = [
    ./browsers.nix
    ./chat.nix
    ./documents.nix
    ./games.nix
  ];

  home.packages = with pkgs; [
    dolphin
    gimp
    lbry
    # openclonk
    # passky
  ];
}
