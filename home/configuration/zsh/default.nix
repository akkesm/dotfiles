{ config, lib, pkgs, ... }:

{
  programs.zsh = {
    enable = true;
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
      extended = true;
      ignoreDups = false; # Set HIST_IGNORE_ALL_DUPS later
      ignorePatterns = [ "q" "kill *" ];
      path = "${config.home.homeDirectory}/${config.programs.zsh.dotDir}/zsh_history";
    };

    initExtraFirst = ''
      if [[ -r "${config.xdg.cacheHome}/p10k-instant-prompt-''${(%):-%n}.zsh" ]]; then
        source "${config.xdg.cacheHome}/p10k-instant-prompt-''${(%):-%n}.zsh"
      fi
    '';

    initExtra =
      let
        opts = lib.concatMapStrings (o: "setopt " + o + "\n") [
          # https://zsh.sourceforge.io/Doc/Release/Options.html

          # Changing Directories
          # "AUTO_CD"
          "AUTO_PUSHD"
          "PUSHD_IGNORE_DUPS"

          # Completion
          "ALWAYS_TO_END"
          "AUTO_MENU"
          "COMPLETE_IN_WORD"
          "GLOB_COMPLETE"
          "EQUALS"
          "GLOBDOTS"
          "GLOB_STAR_SHORT"
          "HIST_SUBST_PATTERN"
          "RC_EXPAND_PARAM"
          "REMATCH_PCRE"
          # "WARN_CREATE_GLOBAL"
          # "WARN_NESTED_VAR"

          # History
          # "EXTENDED_HISTORY"
          "HIST_IGNORE_ALL_DUPS"
          # "HIST_IGNORE_SPACE"
          "HIST_NO_STORE"
          "HIST_REDUCE_BLANKS"
          "HIST_VERIFY"

          # Input/Output
          "INTERACTIVE_COMMENTS"

          # Job Control
          "AUTO_CONTINUE"
          "LONG_LIST_JOBS"

          # Scripts and Functions
          "PIPE_FAIL"
        ];
      in
      ''
        ${opts}

        unsetopt MENU_COMPLETE

        source "${./.}/p10k.zsh"
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
