{ config, ... }:

{
  services = {
    tlp = {
      enable = true;
      settings = {
        SOUND_POWER_SAVE_ON_AC = 0;
        SOUND_POWER_SAVE_ON_BAT = 0;
        SOUND_POWER_SAVE_CONTROLLER = "Y";
        START_CHARGE_THRESH_BAT0 = 60;
        STOP_CHARGE_THRESH_BAT0 = 85;
        NATACPI_ENABLE = 1;
        TPACPI_ENABLE = 0;
        TPSMAPI_ENABLE = 0;
        CPU_SCALING_GOVERNOR_ON_AC = "schedutil";
        CPU_SCALING_GOVERNOR_ON_BAT = "schedutil";
        CPU_SCALING_MIN_FREQ_ON_AC = 1400000;
        CPU_SCALING_MAX_FREQ_ON_AC = 2900000;
        CPU_SCALING_MIN_FREQ_ON_BAT = 1400000;
        CPU_SCALING_MAX_FREQ_ON_BAT = 2900000;
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
