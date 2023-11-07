{ pkgs, ... }:

{
  home.packages = with pkgs; [
    kafkactl
    jq
  ];

  xdg.configFile."kafkactl/config.yaml".source = ./config.yaml;
}
