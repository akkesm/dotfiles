{ options, config, pkgs, ... }:

{
  programs.bash = {
    enable = true;

    historyControl = [
      "erasedups"
      "ignorespace"
    ];

    historyFileSize = 1000;

    profileExtra = ''
      if [ -e ${config.home.homeDirectory}/.nix-profile/etc/profile.d/nix.sh ]; then
        source ${config.home.homeDirectory}/.nix-profile/etc/profile.d/nix.sh
      fi
    '';

    shellOptions = options.programs.bash.shellOptions.default ++ [
      "pipefail"
    ];
  };
}
