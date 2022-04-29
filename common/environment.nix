{ config, lib, pkgs, ... }:

{
  environment = {
    enableDebugInfo = false;
    memoryAllocator.provider = "libc";

    systemPackages = with pkgs; [
      bat
      bat-extras.batdiff
      bat-extras.batman
      bat-extras.batgrep
      bat-extras.batman

      bc
      cachix
      exa
      fd
      file
      gdb
      openssl
      parted
      ripgrep
      rwhich
      shellcheck
      strace
      unzip
      wget
      zip
    ];
  };

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
      package = pkgs.neovim-master;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
    };

    tmux = {
      enable = true;
      clock24 = true;
      keyMode = "vi";
      newSession = true;
      terminal = "screen-256color";
    };
  };

  services.locate = {
    enable = true;
    interval = "Sat *-*-* 00:00";
    localuser = null;
    locate = pkgs.plocate;
    output = "/var/lib/plocate/plocate.db";
    pruneNames = [ ".bzr" ".cache" ".direnv" ".git" ".hg" ".svn" ];
  };
}
