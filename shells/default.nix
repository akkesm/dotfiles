{ pkgs }:

let
  inherit (pkgs) callPackage;
in
rec {
  default = sops;
  sops = callPackage ./sops { };
  nconfig-latest = callPackage ./nconfig-latest { };
}
