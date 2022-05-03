{ pkgs, ... }:

{
  environment = {
    pathsToLink = [ "/share/zsh" ];

    shellAliases = {
      q = "exit";

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
      hs = "history | ${pkgs.ripgrep}/bin/rg -i";
    };

    shells = [
      pkgs.bashInteractive
      pkgs.zsh
    ];

    systemPackages = [ pkgs.any-nix-shell ];
  };

  programs.zsh = {
    enableBashCompletion = true;
    enableCompletion = true;

    promptInit = ''
      any-nix-shell zsh | source /dev/stdin
    '';
  };
}
