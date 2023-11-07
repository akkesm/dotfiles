{ pkgs, ... }:

{
  home.packages = with pkgs; [
    natscli
      jq
  ];
}
