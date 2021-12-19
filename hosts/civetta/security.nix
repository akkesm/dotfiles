{ config, pkgs, ... }:

{
  security.pam.enableSSHAgentAuth = true;

  services = {
    pcscd.enable = true;

    udev.packages = [
      pkgs.yubikey-manager-qt
      pkgs.yubikey-personalization
    ];
  };

  sops.gnupg.sshKeyPaths = [];
}
