{ config, pkgs, ... }:

{
  home.packages = [ pkgs.gopass-jsonapi ];

  programs.gopass = {
    enable = true;
    package = pkgs.gopass.override { passAlias = true; };
    variables.CHECKPOINT_DISABLE = "true";
    settings = {
      autoclip = true;
      autoimport = false;
      cliptimeout = 30;
      path = "${config.xdg.dataHome}/password-store";
    };
  };
}
