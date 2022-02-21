{ config, pkgs, ... }:

{
  xdg.configFile."matlab/nix.sh".text = ''
    INSTALL_DIR=${config.home.homeDirectory}/Matlab
  '';
}
