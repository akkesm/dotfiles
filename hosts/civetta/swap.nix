{ ... }:

{
  boot.kernelParams = [
    "zswap.enabled=1"
    "zswap.shrinker_enabled=1"
  ];

  swapDevices = [{
    device = "/var/lib/swapfile";
    size = 16384;
  }];
}
