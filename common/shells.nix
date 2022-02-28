{ config, pkgs, ... }:

{
  environment = {
    pathsToLink = [ "/share/zsh" ];

    shells = [
      pkgs.bashInteractive
      pkgs.zsh
    ];
  };

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
  };
}
