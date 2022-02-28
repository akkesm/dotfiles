{ config, lib, pkgs, ... }:

{
  programs = {
    git = {
      enable = true;

      aliases = {
        emptycommit = "commit -a --allow-empty-message -m ''";
      };

      extraConfig = {
        core.editor = "nvim";
        credential.helper = "store";
        diff.tool = "vimdiff";
        difftool.prompt = true;
        help.autoCorrect = "prompt";
        init.defaultBranch = "master";
        merge.tool = "vimdiff";
        pull.rebase = false;
        tag.gpgSign = true;
      };

      signing = {
        key = "14E259475412EC24";
        signByDefault = true;
      };

      userEmail = "${config.accounts.email.accounts.${config.home.username}.address}";
      userName  = "${config.accounts.email.accounts.${config.home.username}.realName}";
    };

    gpg = {
      enable = true;
      homedir = "${config.xdg.configHome}/gnupg";

      scdaemonSettings = {
        card-timeout = "5";
        disable-ccid = true;
      };

      settings = {
        default-key = "50E2669CAB382F4A5F7216670D6BFC01D45EDADD";
        keyserver = "hkps://keys.openpgp.org ";
        keyid-format = "0xlong";
        list-options = "show-uid-validity";
        no-comments = true;
        no-emit-version = true;
        verify-options = "show-uid-validity";
        with-fingerprint = true;
      };
    };

    # https://infosec.mozilla.org/guidelines/openssh
    ssh = {
      enable = true;
      controlMaster = "auto";
      controlPath = "/var/tmp/ssh_mux_%h_%p_%r";
      controlPersist = "1h";

      extraConfig = ''
        HostKeyAlgorithms ssh-ed25519-cert-v01@openssh.com,ssh-rsa-cert-v01@openssh.com,ssh-ed25519,ssh-rsa,ecdsa-sha2-nistp521-cert-v01@openssh.com,ecdsa-sha2-nistp384-cert-v01@openssh.com,ecdsa-sha2-nistp256-cert-v01@openssh.com,ecdsa-sha2-nistp521,ecdsa-sha2-nistp384,ecdsa-sha2-nistp256
        KexAlgorithms curve25519-sha256@libssh.org,ecdh-sha2-nistp521,ecdh-sha2-nistp384,ecdh-sha2-nistp256,diffie-hellman-group-exchange-sha256
        MACs hmac-sha2-512-etm@openssh.com,hmac-sha2-256-etm@openssh.com,umac-128-etm@openssh.com,hmac-sha2-512,hmac-sha2-256,umac-128@openssh.com
        Ciphers chacha20-poly1305@openssh.com,aes256-gcm@openssh.com,aes128-gcm@openssh.com,aes256-ctr,aes192-ctr,aes128-ctr
      '';

      hashKnownHosts = true;

      matchBlocks = {
        "github.com" = {
          hostname = "github.com";
          user = "git";
        };

        "nixos-server,192.168.178.24" = {
          hostname = "192.168.178.24";
          user = "user";
        };
      };

      userKnownHostsFile = "${config.xdg.dataHome}/ssh/known_hosts";
    };
  };

  xdg.dataFile."ssh/known_hosts".text = ''
    github.com,140.82.121.4 ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOMqqnkVzrm0SdG6UOoqKLsabgH5C9okWi0dh2l9GKJl
    github.com,140.82.121.4 ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEAq2A7hRGmdnm9tUDbO9IDSwBK6TbQa+PXYPCPy6rbTrTtw7PHkccKrpp0yVhp5HdEIcKr6pLlVDBfOLX9QUsyCOV0wzfjIJNlGEYsdlLJizHhbn2mUjvSAHQqZETYP81eFzLQNnPHt4EVVUh7VfDESU84KezmD5QlWpXLmvU31/yMf+Se8xhHTvKSCZIFImWwoG6mbUoWf9nzpIoaSjB+weqqUUmpaaasXVal72J+UX2B+2RPW3RcT0eOzQgqlJL3RKrTJvdsjE3JEAvGq3lGHSZXy28G3skua2SmVi/w4yCE6gbODqnTWlg7+wC604ydGXA8VJiS5ap43JXiUFFAaQ==
    github.com,140.82.121.4 ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBEmKSENjQEezOmxkZMy7opKgwFB9nkt5YRrYMjNuG5N87uRgg6CLrbo5wAdT/y6v0mKV0U2w0WZ2YB/++Tpockg=
    192.168.178.24 ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFcv3qVMZPeRBFnZIsj8IDsIndlwbC4RPcPfgDEbyVua
  '';

  home.activation = {
    "gnupgDirPermìssions" = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      $DRY_RUN_CMD chmod $VERBOSE_ARG 700 ${config.programs.gpg.homedir}
    '';

    "sshDirPermìssions" = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      $DRY_RUN_CMD chmod $VERBOSE_ARG 700 ${config.home.homeDirectory}/.ssh
      $DRY_RUN_CMD chmod $VERBOSE_ARG 700 ${config.xdg.dataHome}/ssh
    '';
  };

  services.gpg-agent = {
    enable = true;
    defaultCacheTtl = 1800;
    defaultCacheTtlSsh = 1800;
    enableSshSupport = true;

    # "curses" breaks things
    # "gnome3" requires services.dbus.packages = [ pkgs.gcr ]
    pinentryFlavor = "gtk2";
    sshKeys = [ "9C9B70E57D232FBA6AFF0634A1CDDD6968769723" ];
  };
}
