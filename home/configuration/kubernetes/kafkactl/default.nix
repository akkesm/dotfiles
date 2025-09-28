{ pkgs, ... }:

{
  home.packages = with pkgs; [
    kafkactl
  ];

  xdg.configFile."kafkactl/config.yaml".source = ./config.yaml;
}

