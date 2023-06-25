{ config, ... }:

{
  services.transmission = {
    enable = true;

    openPeerPorts = true;
    openRPCPort = true;

    settings = {
      incomplete-dir-enabled = true;
      trash-original-torrent-files = true;

      cache-size-mb = 128;

      download-queue-size = 10;
      seed-queue-enabled = true;
      seed-queue-size = 20;

      rpc-bind-address = "0.0.0.0";
      rpc-whitelist = "127.0.0.1,::1,192.168.178.*";
    };
  };
}
