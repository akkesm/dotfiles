{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    bat
    bat-extras.batdiff
    bat-extras.batman
    bat-extras.batgrep
    bat-extras.batman

    bc
    cachix
    dateutils
    diskus
    eza
    fd
    file
    gdb
    openssl
    parted
    px
    ripgrep
    rwhich
    sd
    shellcheck
    silent
    strace
    unzip
    wget
    zip
  ];

  programs = {
    git = {
      enable = true;
      config.safe.directory = [
        "/etc/nixos"
        "/persist/dotfiles"
      ];
    };

    less.envVariables.LESS = "--quit-if-one-screen --ignore-case --RAW-CONTROL-CHARS --incsearch";

    neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
    };

    tmux = {
      enable = true;
      clock24 = true;

      extraConfig = ''
        set -g @sidebar-tree-command 'eza --tree --level 2 --all --group-directories-first --noicons'
      '';

      keyMode = "vi";

      plugins = with pkgs.tmuxPlugins; [
        fuzzback
        nord
        resurrect
        sidebar
        tmux-fzf
        tmux-thumbs
        urlview
        # yank
      ];

      terminal = "screen-256color";
    };
  };

  services.locate = {
    enable = true;
    package = pkgs.plocate;
    interval = "Sat *-*-* 00:00";
    output = "/var/lib/plocate/plocate.db";
    pruneNames = [ ".bzr" ".cache" ".direnv" ".git" ".hg" ".svn" ];
  };
}
