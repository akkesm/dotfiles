{ config, pkgs, ... }:

{
  environment = {
    enableDebugInfo = false;
    memoryAllocator.provider = "libc";
    shells = [
      pkgs.bashInteractive
      pkgs.zsh
    ];

    systemPackages = (with config.boot.kernelPackages; [
      bpftrace
      perf
    ]) ++ (with pkgs; [
      bat
      bc
      bpytop
      cachix
      dig
      duf
      exa
      fd
      file
      gdb
      glances
      lsof
      lshw
      man-pages
      manix
      nettools
      nmap
      openssl
      parted
      pciutils
      ranger
      ripgrep
      rwhich
      shellcheck
      strace
      sysstat
      tcpdump
      tldr
      usbutils
      libva-utils
      weighttp
      wget
      whois

      (pkgs.writeShellScriptBin "fs-diff" ''
        set -Eeuo pipefail

        OLD_TRANSID=''$(sudo btrfs subvolume find-new /mnt/root-blank 9999999)
        OLD_TRANSID=''${OLD_TRANSID#transid marker was }

        sudo btrfs subvolume find-new "/mnt/root" "$OLD_TRANSID" |
        sed '$d' |
        cut -f17- -d' ' |
        sort |
        uniq |
        while read path; do
          path="/$path"
          if [ -L "$path" ]; then
            : # The path is a symbolic link, so is probably handled by NixOS already
          elif [ -d "$path" ]; then
            : # The path is a directory, ignore
          else
            echo "$path"
          fi
        done
      '')
    ]);

    variables = {
      EDITOR = "nvim";
      PAGER = "less";
    };
  };

  programs = {
    atop = {
      enable = true;
      setuidWrapper.enable = true;
    };

    bcc.enable = true;

    git = {
      enable = true;
    };

    less = {
      enable = true;
    };

    mtr.enable = true;

    neovim = {
      enable = true;
      package = pkgs.neovim-master;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
    };

    sysdig.enable = true;

    tmux = {
      enable = true;
      clock24 = true;
      keyMode = "vi";
      newSession = true;
      terminal = "screen-256color";
    };

    traceroute.enable = true;
    wireshark.enable = true;
    zmap.enable = true;

    zsh = {
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

      shellInit = ''
        function rwhich () { (which -a ls | sed -n '/^\//p' | uniq | xargs realpath) }
      '';
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
  services = {
    locate = {
      enable = true;
      interval = "Sat *-*-* 00:00";
      localuser = null;
      locate = pkgs.plocate;
      output = "/var/lib/plocate/plocate.db";
      pruneNames = [ ".bzr" ".cache" ".direnv" ".git" ".hg" ".svn" ];
    };

    openssh = {
      enable = true;
      startWhenNeeded = true;
    };
  };

  virtualisation = {
    podman = {
      enable = true;
      dockerCompat = true;
      dockerSocket.enable = true; # Add users to "podman" group
    };

    oci-containers = {
      backend = "podman";
    };
  };
}
