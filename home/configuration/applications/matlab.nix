{ config, pkgs, ... }:

{
  home.packages = [ pkgs.matlab ];

  xdg.configFile."matlab/nix.sh".text = ''
    INSTALL_DIR=${config.home.homeDirectory}/MATLAB
  '';
}
