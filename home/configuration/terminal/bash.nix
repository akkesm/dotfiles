{ config, pkgs, ... }:

{
  programs.bash = {
    enable = true;
    historyFileSize = 1000;
    profileExtra = ''
      if [ -e ${config.home.homeDirectory}/.nix-profile/etc/profile.d/nix.sh ]; then
        source ${config.home.homeDirectory}/.nix-profile/etc/profile.d/nix.sh
      fi
    '';
    shellAliases = {
      q = "exit";
    };
  };
}
