{ config, lib, pkgs, ... }:

{
  home.packages = [ pkgs.wl-clipboard ];
  services.copyq.enable = true;

  wayland.windowManager.sway.config = {
    floating.criteria = [{ class = "copyq"; }];

    keybindings =
      let mod = config.wayland.windowManager.sway.config.modifier;
      in lib.mkOptionDefault { "${mod}+p" = "exec ${pkgs.copyq}/bin/copyq show"; };
  };
}
