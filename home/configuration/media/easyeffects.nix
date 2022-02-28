{ config, pkgs, ... }:

{
  services.easyeffects.enable = true;

  xdg.configFile = {
    "easyeffects/autoload/output/autoeq-harman-oe-2018-logitech-g-pro-x-minimum-phase-44100.wav".source = pkgs.fetchurl {
      name = "autoeq-harman-oe-2018-logitech-g-pro-x-minimum-phase-44100.wav";
      url = "https://github.com/jaakkopasanen/AutoEq/raw/master/results/crinacle/gras_43ag-7_harman_over-ear_2018/Logitech G Pro X/Logitech G Pro X minimum phase 44100Hz.wav";
      sha256 = "1949y0m8zwrkf7f497kcaiid1c03apb239zwhrj1g1xcqq8jmzdx";
    };

    "easyeffects/autoload/output/autoeq-harman-oe-2018-logitech-g-pro-x-minimum-phase-48000.wav".source = pkgs.fetchurl {
      name = "autoeq-harman-oe-2018-logitech-g-pro-x-minimum-phase-48000.wav";
      url = "https://github.com/jaakkopasanen/AutoEq/raw/master/results/crinacle/gras_43ag-7_harman_over-ear_2018/Logitech G Pro X/Logitech G Pro X minimum phase 48000Hz.wav";
      sha256 = "0l7ncri7p97ranlq2d7nci93anbm1dg1njw5wj52wcb0smxbl0ky";
    };
  };
}
