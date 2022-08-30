{ pkgs, ... }:

{
  security.pam.enableSSHAgentAuth = true;

  services = {
    pcscd.enable = true;

    udev.packages = [
      pkgs.yubikey-manager-qt
      pkgs.yubikey-personalization
    ];
  };

  security.sudo = {
    execWheelOnly = true;

    extraConfig = ''
      Defaults lecture = never
    '';

    wheelNeedsPassword = false;
  };

  users.mutableUsers = false;
}
