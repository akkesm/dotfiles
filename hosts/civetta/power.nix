{ ... }:

{
  # Enable for amd-pstate
  # boot.kernelParams = [ "initcall_blacklist=acpi_cpufreq_init" ];

  services = {
    tlp = {
      enable = true;
      settings = {
        SOUND_POWER_SAVE_ON_AC = 0;
        SOUND_POWER_SAVE_ON_BAT = 10;
        SOUND_POWER_SAVE_CONTROLLER = "Y";
        START_CHARGE_THRESH_BAT0 = 20;
        STOP_CHARGE_THRESH_BAT0 = 85;
        DISK_APM_LEVEL_ON_AC = "keep keep";
        DISK_APM_LEVEL_ON_BAT = "keep keep";
        DISK_IOSCHED = "keep keep";
        WIFI_PWR_ON_BAT = "off";
        WOL_DISABLE = "N";
        # Enable for amd-pstate
        # CPU_DRIVER_OPMODE_ON_AC = "active";
        # CPU_DRIVER_OPMODE_ON_BAT = "guided";
        CPU_SCALING_GOVERNOR_ON_AC = "schedutil"; # Change to "powersave" with amd-pstate
        CPU_SCALING_GOVERNOR_ON_BAT = "schedutil";
        RESTORE_DEVICE_STATE_ON_STARTUP = 1;
        USB_AUTOSUSPEND = 0;
      };
    };

    upower = {
      enable = true;
      criticalPowerAction = "PowerOff";
      percentageAction = 5;
      percentageCritical = 5;
      percentageLow = 10;
    };
  };
}
