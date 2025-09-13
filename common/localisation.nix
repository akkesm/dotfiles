{ ... }:

{
  console.keyMap = "it";

  i18n = {
    defaultLocale = "it_IT.UTF-8";
    extraLocaleSettings.LC_MESSAGES = "en_US.UTF-8";

    supportedLocales = [
      "en_GB.UTF-8/UTF-8"
      "en_US.UTF-8/UTF-8"
      "es_ES.UTF-8/UTF-8"
      "it_IT.UTF-8/UTF-8"
    ];
  };

  services.chrony.enable = true;

  time.timeZone = "Europe/Rome";
}
