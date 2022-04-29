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

  # 20211122 the module only has options for mlocate, not plocate
  users.groups.plocate = { };
  security.wrappers.locate = {
    group = "plocate";
    owner = "root";
    permissions = "u+rx,g+x,o+x";
    setgid = true;
    setuid = false;
    source = "${config.services.locate.locate}/bin/plocate";
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
