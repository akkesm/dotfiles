{ config, pkgs, ... }:

{
  environment.shells = [
    pkgs.bashInteractive
    pkgs.zsh
  ];

  programs.zsh = {
    enableBashCompletion = true;
    enableCompletion = true;

    shellAliases = {
      q = "exit";

      batman = "batman --paging=auto";
      ccat = "bat";

      cdtmp = "cd $(mktemp -d)";

      ll = "exa --long --group-directories-first --links --binary --group --time-style long-iso --icons";
      la = "exa --long --group-directories-first --links --binary --group --time-style long-iso --icons --all";

      h = "history";
      hs = "history | grep -i";
    };

    promptInit = ''
      any-nix-shell zsh | source /dev/stdin
    '';

    shellInit = ''
      function rwhich () { (which -a ls | sed -n '/^\//p' | uniq | xargs realpath) }
    '';
  };
}
