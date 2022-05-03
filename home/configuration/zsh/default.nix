{ config, lib, pkgs, ... }:

{
  home.file."${config.programs.zsh.dotDir}/.p10k.zsh".source = ./p10k.zsh;

  programs.zsh = {
    enable = true;
    enableAutosuggestions = false;
    enableSyntaxHighlighting = true;
    autocd = true;
    defaultKeymap = "viins";

    envExtra = ''
      if [[ -e ${config.home.homeDirectory}/.nix-profile/etc/profile.d/nix.sh ]]; then
        source ${config.home.homeDirectory}/.nix-profile/etc/profile.d/nix.sh
      fi
    '';

    dotDir =
      let
        relativeConfigHome = lib.removePrefix
          (config.home.homeDirectory + "/")
          config.xdg.configHome;
      in
      relativeConfigHome + "/zsh";

    history = {
      expireDuplicatesFirst = true;
      extended = true;
      ignorePatterns = [ "q" "kill *" ];
      path = "${config.home.homeDirectory}/${config.programs.zsh.dotDir}/zsh_history";
    };

    initExtraFirst = ''
      if [[ -r "${config.xdg.cacheHome}/p10k-instant-prompt-''${(%):-%n}.zsh" ]]; then
        source "${config.xdg.cacheHome}/p10k-instant-prompt-''${(%):-%n}.zsh"
      fi
    '';

    initExtra = ''
      setopt HIST_IGNORE_ALL_DUPS

      any-nix-shell zsh | source /dev/stdin

      [[ ! -f ${config.home.homeDirectory}/${config.programs.zsh.dotDir}/.p10k.zsh ]] || source ${config.home.homeDirectory}/${config.programs.zsh.dotDir}/.p10k.zsh
    '';

    localVariables.POWERLEVEL9K_DISABLE_CONFIGURATION_WIZARD = true;

    oh-my-zsh = {
      enable = true;
      custom = "${config.home.homeDirectory}/${config.programs.zsh.dotDir}/oh-my-zsh/custom";
      plugins = [
        "copybuffer"
        "extract"
        "pass"
        "torrent"
        "zsh-interactive-cd"
      ];
    };

    plugins = [
      {
        name = "zsh-nix-shell";
        src = pkgs.zsh-nix-shell;
        file = "share/zsh-nix-shell/nix-shell.plugin.zsh";
      }
      {
        name = "zsh-powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
      # {
      #   name = "zsh-vi-mode";
      #   src = pkgs.zsh-vi-mode;
      #   file = "share/zsh-vi-mode/zsh-vi-mode.zsh";
      # }
      # {
      #   name = "oh-my-zsh-copybuffer";
      #   src = oh-my-zsh-src;
      #   file = "plugins/copybuffer/copybuffer.plugin.zsh";
      # }
      # {
      #   name = "oh-my-zsh-extract";
      #   src = oh-my-zsh-src;
      #   file = "plugins/extract/extract.plugin.zsh";
      # }
    ];
  };
}
