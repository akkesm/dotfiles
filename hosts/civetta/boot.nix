{ config, ... }:

{
  boot = {
    enableContainers = true;
    consoleLogLevel = 4;

    loader = {
      efi.canTouchEfiVariables = true;

      systemd-boot = {
        enable = true;
        consoleMode = "max";
        configurationLimit = 4;
        editor = false;
      };

      timeout = 5;
    };
  };
}
