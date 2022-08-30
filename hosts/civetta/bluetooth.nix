{ ... }:

{
  hardware.bluetooth = {
    enable = true;
    disabledPlugins = [ "sap" ];
    powerOnBoot = false;
  };
}
