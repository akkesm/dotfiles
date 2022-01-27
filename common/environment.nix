{ config, pkgs, ... }:

{
  environment = {
    enableDebugInfo = false;
    memoryAllocator.provider = "libc";

    systemPackages = with pkgs; [
      any-nix-shell
      bat
      bc
      cachix
      exa
      fd
      file
      gdb
      openssl
      parted
      ranger
      ripgrep
      rwhich
      shellcheck
      strace
      wget
    ];

    variables = {
      EDITOR = "nvim";
      PAGER = "less";
    };
  };

  programs = {

    git = {
      enable = true;
    };

    less = {
      enable = true;
    };

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
  users.groups.plocate = {};
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
