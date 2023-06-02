{ ... }:

{
  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = false;
    startWhenNeeded = true;
  };

  users.users.root.openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFVWvZSum7H40IKR6yyvSuz3zXCEKGFYWpBzc0qB5vj3 cardno:15 454 659" ];
}
