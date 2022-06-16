{ config, pkgs, ... }:

{
  users = {
    defaultUserShell = pkgs.zsh;
    mutableUsers = false;

    users."alessandro" = {
      description = "Alessandro Barenghi";

      extraGroups = [
        "adbusers"
        "keys"
        "libvirtd"
        "lp"
        "podman"
        "scanner"
        "video"
        "wheel"
      ];

      initialHashedPassword = "$6$Hx7jqQUP$WEm9LBVxX/BJGZI3e1NqlYtHTyMERYLEl02Q5e3dGFLPvVzYpvr9ULXcxNF4K1SLWRHnnscZv5qBTpGxAsPSy1";
      isNormalUser = true;
      passwordFile = config.sops.secrets.password-alessandro.path;
      name = "alessandro";
      uid = 1000;
    };
  };

  security = {
    sudo = {
      execWheelOnly = true;

      extraConfig = ''
        Defaults lecture = never
      '';

      wheelNeedsPassword = false;
    };

    pam.yubico = {
      enable = true;
      challengeResponsePath = "/var/yubico";
      mode = "challenge-response";
    };
  };

  sops.secrets = {
    # Add users to "keys" group
    password-alessandro = {
      format = "yaml";
      neededForUsers = true;
      sopsFile = ./secrets/passwords.yaml;
    };

    config-cachix = {
      format = "yaml";
      owner = config.users.users.alessandro.name;
      path = "${config.users.users.alessandro.home}/.config/cachix/cachix.dhall";
      sopsFile = ./secrets/cachix.yaml;
    };
  };

  # TODO make into module 
  # environment = {
  #   systemPackages = [ pkgs.ly ];
  #   etc."ly/config.ini".text = ''
  #     animate = false
  #     animation = 0
  #     asterisk = *
  #     bg = 0
  #     blank_password = false
  #     fg = 9
  #     hide_borders = true
  #     lang = it
  #     mcookie_cmd = ${pkgs.util-linux}/bin/mcookie
  #     path = /bin:/usr/bin
  #     restart_cmd = ${pkgs.systemd}/bin/systemctl reboot
  #     save_file = /persist/etc/ly/save
  #     shutdown = ${pkgs.systemd}/bin/systemctl poweroff
  #     term_reset_cmd = ${pkgs.ncurses}/bin/tput rest
  #   '';
  # };
  # security.pam.services."ly".text = ''
  #   #%PAM-1.0

  #   auth       include      login
  #   account    include      login
  #   password   include      login
  #   session    include      login
  # '';
  # systemd.services."ly" = {
  #   aliases = [ "display-manager.service" ];
  #   after = [
  #     "systemd-user-sessions.service plymouth-quit-wait.service"
  #     "getty@tty2.service"
  #   ];
  #   description = "TUI display manager";
  #   serviceConfig = {
  #     oType = "idle";
  #     ExecStart = "/usr/bin/ly";
  #     StandardInput = "tty";
  #     TTYPath = "/dev/tty2";
  #     TTYReset = "yes";
  #     TTYVHangup = "yes";
  #   };
  # };
}
