{ pkgs, ... }:

{
  services.easyeffects = {
    enable = true;
  };

  # https://github.com/jaakkopasanen/AutoEq/blob/master/results/crinacle/gras_43ag-7_harman_over-ear_2018/Logitech%20G%20Pro%20X/Logitech%20G%20Pro%20X%20ParametricEQ.txt
  xdg.configFile."easyeffects/output/autoeq-harman-oe-2018-logitech-g-pro-x.txt".text = ''
      Preamp: -6.8 dB
      Filter 1: ON PK Fc 137 Hz Gain -8.8 dB Q 1.06
      Filter 2: ON PK Fc 3726 Hz Gain 5.9 dB Q 2.25
      Filter 3: ON PK Fc 7783 Hz Gain 2.6 dB Q 1.49
      Filter 4: ON PK Fc 11470 Hz Gain 4.0 dB Q 1.14
      Filter 5: ON PK Fc 16557 Hz Gain 3.0 dB Q 0.59
      Filter 6: ON PK Fc 13 Hz Gain -2.3 dB Q 0.08
      Filter 7: ON PK Fc 61 Hz Gain 4.6 dB Q 3.09
      Filter 8: ON PK Fc 230 Hz Gain -5.1 dB Q 1.97
      Filter 9: ON PK Fc 255 Hz Gain 4.3 dB Q 0.72
      Filter 10: ON PK Fc 1531 Hz Gain -2.8 dB Q 4.87
    '';

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
