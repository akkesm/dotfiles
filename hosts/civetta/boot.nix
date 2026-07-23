
{
  boot = {
    initrd.systemd.enable = false; # TODO: remove before 26.11

    loader = {
      efi.canTouchEfiVariables = true;

      systemd-boot = {
        enable = true;
        consoleMode = "max";
        configurationLimit = 4;
        editor = false;
      };
    };
  };

  hardware.cpu.intel.updateMicrocode = true;
}
