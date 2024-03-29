{ pkgs, ... }:

{
  fonts = {
    fontconfig.enable = true;

    emoji = "Twitter Color Emoji";
    monospace = "IosevkaTerm Nerd Font Mono";
    sansSerif = "MesloLGMDZ Nerd Font";
    serif = "Roboto Slab";

    fonts = with pkgs; [
      twemoji-color-font
      ttf_bitstream_vera

      (nerdfonts.override {
        fonts = [
          "FiraCode"
          "Iosevka"
          "IosevkaTerm"
          "Meslo"
        ];
      })

      roboto-slab
      dejavu_fonts
      freefont_ttf
      gyre-fonts
      liberation_ttf
      unifont
      noto-fonts-emoji
    ];
  };
}
