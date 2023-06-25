{ ... }:

{
  networking = {
    hostName = "media";
    defaultGateway = "192.168.178.1";

    interfaces.enp1s0 = {
      ipv4.addresses = [{
        address = "192.168.178.3";
        prefixLength = 24;
      }];

      wakeOnLan.enable = true;
    };

    nameservers = [
      "9.9.9.9"
      "149.112.112.112"
      "2620:fe::fe"
      "2620:fe::9"
    ];

    useDHCP = false;
  };
}
