{ pkgs, ... }:

{
  security.pam.sshAgentAuth.enable = true;

  services = {
    pcscd.enable = true;

    udev.packages = [
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
