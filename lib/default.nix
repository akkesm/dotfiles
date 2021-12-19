{ lib }:

let
  callLibs = file: import file { inherit lib; };
in
rec {
  trivial = callLibs ./trivial.nix;

  inherit (trivial) pow hexToDec colorHexToRgbString;
}
