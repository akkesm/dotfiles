{ pkgs, ... }:

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

  programs.zsh = {
    enableBashCompletion = true;
    enableCompletion = true;
  };

  users.defaultUserShell = pkgs.zsh;
}
