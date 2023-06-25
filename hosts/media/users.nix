{ config, pkgs, ... }:

{
  users = {
    defaultUserShell = pkgs.zsh;
    mutableUsers = false;

    users.alessandro = {
      openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFVWvZSum7H40IKR6yyvSuz3zXCEKGFYWpBzc0qB5vj3 cardno:15 454 659" ];

      extraGroups = [
        "keys"
        "wheel"
      ];

      isNormalUser = true;
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
}
