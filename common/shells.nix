{ config, lib, pkgs, ... }:

{
  environment = {
    pathsToLink = [ "/share/zsh" ];

    shellAliases = {
      q = "exit";

      cdtmp = "cd \"$(mktemp -d)\"";

      ll = "${pkgs.exa}/bin/exa --long --group-directories-first --links --binary --group --time-style long-iso --icons";
      la = "${pkgs.exa}/bin/exa --long --group-directories-first --links --binary --group --time-style long-iso --icons --all";

      gits = "${pkgs.git}/bin/git status";

      h = "history";
      hs = "history | ${pkgs.ripgrep}/bin/rg -i";
    };

    shells = [
      pkgs.bashInteractive
      pkgs.zsh
    ];
  };

  programs = {
    bash.shellInit = ''
      set -o pipefail
    '';

    zsh = {
      enable = true;
      enableBashCompletion = true;
      enableCompletion = true;

      shellInit =
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
          "MENU_COMPLETE"

          # Expansion and Globbing
          "EQUALS"
          "GLOB_DOTS"
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
        '';
    };
  };

  users.defaultUserShell = pkgs.zsh;
}
