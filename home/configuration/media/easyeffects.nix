{ config, pkgs, ... }:

{
  services.easyeffects = {
    enable = true;
    preset = "autoeq-harman-oe-2018-logitech-g-pro-x.txt";
  };

  xdg.configFile = {
    "easyeffects/autoload/output/autoeq-harman-oe-2018-logitech-g-pro-x-minimum-phase-44100.wav".source = pkgs.fetchurl {
      name = "autoeq-harman-oe-2018-logitech-g-pro-x-minimum-phase-44100.wav";
      url = "https://github.com/jaakkopasanen/AutoEq/raw/master/results/crinacle/gras_43ag-7_harman_over-ear_2018/Logitech%20G%20Pro%20X/Logitech%20G%20Pro%20X%20minimum%20phase%2044100Hz.wav";
      sha256 = "1949y0m8zwrkf7f497kcaiid1c03apb239zwhrj1g1xcqq8jmzdx";
    };

    "easyeffects/autoload/output/autoeq-harman-oe-2018-logitech-g-pro-x-minimum-phase-48000.wav".source = pkgs.fetchurl {
      name = "autoeq-harman-oe-2018-logitech-g-pro-x-minimum-phase-48000.wav";
      url = "https://github.com/jaakkopasanen/AutoEq/raw/master/results/crinacle/gras_43ag-7_harman_over-ear_2018/Logitech%20G%20Pro%20X/Logitech%20G%20Pro%20X%20minimum%20phase%2048000Hz.wav";
      sha256 = "0l7ncri7p97ranlq2d7nci93anbm1dg1njw5wj52wcb0smxbl0ky";
    };
  };
}
