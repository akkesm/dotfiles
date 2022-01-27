{ config, ... }:

{
  imports = [
    ./containers.nix
    ./docs.nix
    ./environment.nix
    ./localisation.nix
    ./monitoring.nix
    ./nix.nix
    ./shells.nix
    ./ssh.nix
  ];
}
