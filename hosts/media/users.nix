{ config, pkgs, ... }:

{
  users = {
    defaultUserShell = pkgs.zsh;
    mutableUsers = false;

    users.alessandro = {
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFVWvZSum7H40IKR6yyvSuz3zXCEKGFYWpBzc0qB5vj3 (none)"
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAII1snsy3j32bczZzRX4wsMm8qY4/XJl5tcaI0wGXqoEC cardno:15_454_659"
      ];

      extraGroups = [
        "keys"
        "lp"
        "podman"
        "scanner"
        "wheel"
      ];

      isNormalUser = true;
      hashedPasswordFile = config.sops.secrets.password-alessandro.path;
      useDefaultShell = true;
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
  };

  sops.secrets = {
    # Add users to "keys" group
    password-alessandro = {
      format = "yaml";
      neededForUsers = true;
      sopsFile = ../civetta/secrets/passwords.yaml;
    };

    config-cachix = {
      format = "yaml";
      owner = config.users.users.alessandro.name;
      path = "${config.users.users.alessandro.home}/.config/cachix/cachix.dhall";
      sopsFile = ../civetta/secrets/cachix.yaml;
    };
  };
}
