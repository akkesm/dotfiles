{ pkgs }:

let
  inherit (pkgs) callPackage;
in
{
  sops = callPackage ./sops { };
  nconfig-latest = callPackage ./nconfig-latest { };
}
