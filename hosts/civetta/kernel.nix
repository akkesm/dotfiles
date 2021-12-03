{ config, pkgs, ... }:

{
  boot = {
    kernel.sysctl = {
      "abi.vsyscall32" = 0; # Fixes a WINE bug
      "vm.swappiness" = 200;
    };

    kernelPackages = pkgs.linuxPackages_latest;
    kernelParams = [ "acpi_backlight=native" ];
  };
}
