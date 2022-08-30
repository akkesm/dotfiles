
{
  boot = {
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
}
