{ config, pkgs, ... }:

{
  boot = {
    kernel.sysctl = {
      "abi.vsyscall32" = 0; # Fixes a WINE bug
    };

    kernelPackages = pkgs.linuxPackages_latest;
    kernelParams = [ "acpi_backlight=native" ];
  };
}
