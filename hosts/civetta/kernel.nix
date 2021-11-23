{ config, pkgs, ... }:

{
  boot = {
    kernel.sysctl = {
      "vm.swappiness" = 200;
    };

    kernelPackages = pkgs.linuxPackages_latest;
    kernelParams = [ "acpi_backlight=native" ];
  };
}
