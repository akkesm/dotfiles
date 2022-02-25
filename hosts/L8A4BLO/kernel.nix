{ config, pkgs, ... }:

{
  boot = {
    kernel.sysctl = {
      "abi.vsyscall32" = 0; # Fixes a WINE bug
    };

    kernelPackages = pkgs.linuxPackages_L8A4BLO;
    kernelParams = [ "acpi_backlight=native" ];
  };
}
