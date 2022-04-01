{ pkgs, ... }:

{
  # fonts = {
  #   enableDefaultFonts = true;

  #   fontconfig = {
  #     enable = true;
  #     cache32Bit = true;

  #     defaultFonts = {
  #       emoji = [ "twemoji-color-font" ];

  #       monospace = [
  #         "Iosevka Term"
  #         "Sarasa Mono SC"
  #       ];

  #       sansSerif = [
  #         "Meslo"
  #         "Iosevka"
  #         "Sarasa Gothic SC"
  #         "Unifont"
  #       ];

  #       serif = [
  #         "Roboto Slab"
  #       ];
  #     };
  #   };

  #   fonts = with pkgs; [
  #     (nerdfonts.override { fonts = [
  #      "FiraCode"
  #      "Iosevka"
  #     ]; })
  #     sarasa-gothic
  #     unifont

  #     liberation_ttf
  #     symbola
  #     vistafonts

  #     roboto-slab
  #   ];
  # };

}

