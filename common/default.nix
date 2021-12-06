{ config, ... }:

{
  imports = [
    ./environment.nix
    ./containers.nix
    ./docs.nix
    ./localisation.nix
    ./monitoring.nix
    ./nix.nix
    ./shells.nix
  ];
}
