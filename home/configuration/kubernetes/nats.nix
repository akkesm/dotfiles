{ pkgs, ... }:

{
  home.packages = with pkgs; [
    natscli
  ];
}
