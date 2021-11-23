{ config, pkgs, ... }:

{
  console.keyMap = "it";

  i18n = {
    defaultLocale = "it_IT.UTF-8";

    extraLocaleSettings = {
      LC_MESSAGES = "en_US.UTF-8";
    };

    supportedLocales = [
      "de_DE.UTF-8/UTF-8"
      "en_GB.UTF-8/UTF-8"
      "en_US.UTF-8/UTF-8"
      "es_ES.UTF-8/UTF-8"
      "fr_FR.UTF-8/UTF-8"
      "it_IT.UTF-8/UTF-8"
    ];
  };

  time.timeZone = "Europe/Rome";
}
