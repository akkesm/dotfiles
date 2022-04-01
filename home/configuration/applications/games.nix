{ pkgs, ... }:

{
  home.packages = with pkgs; [
    lutris
    steam
  ];
}
