{ pkgs, ... }:

{
  services.easyeffects = {
    enable = true;
  };

  # https://github.com/jaakkopasanen/AutoEq/blob/master/results/crinacle/gras_43ag-7_harman_over-ear_2018/Logitech%20G%20Pro%20X/Logitech%20G%20Pro%20X%20ParametricEQ.txt
  xdg.configFile."easyeffects/output/autoeq-harman-oe-2018-logitech-g-pro-x.txt".text = ''
    Preamp: -6.97 dB
    Filter 1: ON LSC Fc 105.0 Hz Gain -1.1 dB Q 0.70
    Filter 2: ON PK Fc 35.6 Hz Gain 1.8 dB Q 2.90
    Filter 3: ON PK Fc 62.8 Hz Gain 5.6 dB Q 2.47
    Filter 4: ON PK Fc 88.3 Hz Gain -2.3 dB Q 2.75
    Filter 5: ON PK Fc 159.7 Hz Gain -8.0 dB Q 0.85
    Filter 6: ON PK Fc 372.9 Hz Gain 3.4 dB Q 1.80
    Filter 7: ON PK Fc 1540.4 Hz Gain -2.3 dB Q 4.06
    Filter 8: ON PK Fc 3679.9 Hz Gain 6.4 dB Q 2.24
    Filter 9: ON PK Fc 8347.3 Hz Gain 3.6 dB Q 1.22
    Filter 10: ON HSC Fc 10000.0 Hz Gain 4.3 dB Q 0.70
  '';

  # xdg.configFile = {
  #   "easyeffects/autoload/output/autoeq-harman-oe-2018-logitech-g-pro-x-minimum-phase-44100.wav".source = pkgs.fetchurl {
  #     name = "autoeq-harman-oe-2018-logitech-g-pro-x-minimum-phase-44100.wav";
  #     url = "https://github.com/jaakkopasanen/AutoEq/raw/master/results/crinacle/gras_43ag-7_harman_over-ear_2018/Logitech%20G%20Pro%20X/Logitech%20G%20Pro%20X%20minimum%20phase%2044100Hz.wav";
  #     sha256 = "1949y0m8zwrkf7f497kcaiid1c03apb239zwhrj1g1xcqq8jmzdx";
  #   };
  #
  #   "easyeffects/autoload/output/autoeq-harman-oe-2018-logitech-g-pro-x-minimum-phase-48000.wav".source = pkgs.fetchurl {
  #     name = "autoeq-harman-oe-2018-logitech-g-pro-x-minimum-phase-48000.wav";
  #     url = "https://github.com/jaakkopasanen/AutoEq/raw/master/results/crinacle/gras_43ag-7_harman_over-ear_2018/Logitech%20G%20Pro%20X/Logitech%20G%20Pro%20X%20minimum%20phase%2048000Hz.wav";
  #     sha256 = "0l7ncri7p97ranlq2d7nci93anbm1dg1njw5wj52wcb0smxbl0ky";
  #   };
  # };
}
