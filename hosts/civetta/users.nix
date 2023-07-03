{ config, ... }:

{
  users.users.alessandro = {
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

    isNormalUser = true;
    passwordFile = config.sops.secrets.password-alessandro.path;
    uid = 1000;
  };

  security.pam.yubico = {
    enable = true;
    challengeResponsePath = "/var/yubico";
    mode = "challenge-response";
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
}
