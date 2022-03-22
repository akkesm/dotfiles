{ lib }:

let
  callLibs = file: import file { inherit lib; };
in
rec {
  colors = callLibs ./colors.nix;
  packages = callLibs ./packages.nix;

  inherit (colors) pow hexToDec colorHexToRgbString;
  inherit (packages) genDateVersion;
}
