{ config, lib, pkgs, ... }:

let
  inherit (lib) mkOption types;
in
{
  options.fonts = {
    emoji = mkOption {
      type = types.str;
      default = "Noto Color Emoji";
      description = ''
        The primary font for emojis.
      '';
    };

    monospace = mkOption {
      type = types.str;
      default = "DejaVu Sans Mono";
      description = ''
        The primary monospace font.
      '';
    };

    sansSerif = mkOption {
      type = types.str;
      default = "DejaVu Sans";
      description = ''
        The primary sans serif font.
      '';
    };

    serif = mkOption {
      type = types.str;
      default = "DejaVu Serif";
      description = ''
        The primary serif font.
      '';
    };

    fonts = mkOption {
      type = types.listOf types.package;
      default = [ pkgs.dejavu_fonts ];
      description = ''
        List of primary font paths.
      '';
    };
  };

  config.home.packages = config.fonts.fonts;
}
