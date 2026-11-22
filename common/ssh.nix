{ ... }:

{
  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = false;
    startWhenNeeded = true;
  };

  users.users.root.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFVWvZSum7H40IKR6yyvSuz3zXCEKGFYWpBzc0qB5vj3 (none)"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAII1snsy3j32bczZzRX4wsMm8qY4/XJl5tcaI0wGXqoEC cardno:15_454_659"
  ];
}

