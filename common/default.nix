{ config, ... }:

{
  imports = [
    ./environment.nix
    ./localisation.nix
    ./nix.nix
  ];
}
