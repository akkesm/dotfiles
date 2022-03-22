{ lib }:

let
  inherit (builtins) substring;
in
{
  genDateVersion = input:
    lib.concatStringsSep "-" [
      (substring 0 4 input.lastModifiedDate)
      (substring 4 2 input.lastModifiedDate)
      (substring 7 2 input.lastModifiedDate)
    ];
}
