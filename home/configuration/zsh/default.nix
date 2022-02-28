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
      in relativeConfigHome + "/zsh";

    history = {
      expireDuplicatesFirst = true;
      extended = true;
      ignoreDups = true;  #default
      ignorePatterns = [ "q" ];
      ignoreSpace = true; #default
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

    localVariables = {
      POWERLEVEL9K_DISABLE_CONFIGURATION_WIZARD = true;
    };

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

    shellAliases = {
      q = "exit";

      batman = "batman --paging=auto";

      cdtmp = "cd $(mktemp -d)";

      dnfl = "dnf list";
      dnfli = "dnf list installed";
      dnfq = "dnf info";
      dnfs = "dnf search";
      dnfdep = "dnf repoquery --requires --resolve";
      dnfreq = "dnf repoquery --exactdeps --whatrequires";
      dnfp = "dnf provides";
      dnfa = "sudo dnf autoremove";
      dnfc = "sudo dnf clean all";
      dnfi = "sudo dnf install";
      dnfr = "sudo dnf remove";
      dnfu = "sudo dnf upgrade";

      ll = "exa --long --group-directories-first --links --binary --group --time-style long-iso --icons";
      la = "exa --long --group-directories-first --links --binary --group --time-style long-iso --icons --all";

      gits = "git status";

      h = "history";
      hs = "history | grep -i";
    };

    shellGlobalAliases = {
      ncg = "nix-collect-garbage && nix store optimise";
    };
  };
}
