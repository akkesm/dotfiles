{ ... }:

{
  boot.kernel.sysctl = { "vm.swappiness" = 200; };

  systemd.oomd.enable = true;

  zramSwap = {
    enable = true;
    memoryPercent = 150;
  };
}
