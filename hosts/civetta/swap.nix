{ config, ... }:

{
  boot.kernel.sysctl = { "vm.swappiness" = 200; };

  zramSwap = {
    enable = true;
    memoryPercent = 100;
  };
}
