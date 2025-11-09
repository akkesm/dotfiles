{ pkgs, ... }:

{
  fonts = {
    fontconfig.enable = true;

    emoji = "Twitter Color Emoji";
    monospace = "IosevkaTerm Nerd Font Mono";
    sansSerif = "MesloLGMDZ Nerd Font";
    serif = "Roboto Slab";

    fonts = with pkgs; with pkgs.nerd-fonts; [
      twemoji-color-font
      ttf_bitstream_vera

      iosevka
      iosevka-term
      fira-code
      meslo-lg

      roboto-slab
      dejavu_fonts
      freefont_ttf
      gyre-fonts
      liberation_ttf
      unifont
      noto-fonts-color-emoji
    ];
  };
}
