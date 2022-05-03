{ config, lib, pkgs, ... }:

{
  home = {
    activation."lbryHeadersPermissions" = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      $DRY_RUN_CMD chmod $VERBOSE_ARG 644 ${config.xdg.dataHome}/lbry/lbryum/lbc_mainnet/headers
    '';

    packages = [ pkgs.lbry ];
  };
}
