{ pkgs }:

let
  inherit (pkgs) callPackage;
in
rec {
  default = dotfiles;
  dotfiles = callPackage ./dotfiles { };
  nconfig-latest = callPackage ./nconfig-latest { };
}
