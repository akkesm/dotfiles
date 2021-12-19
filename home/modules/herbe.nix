{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.programs.herbe;
in
{
  options.programs.herbe = {
    enable = mkEnableOption "Herbe, Daemon-less notifications without D-Bus";

    settings = {
      backgroundColor = mkOption {
        type = types.str;
        default = "#3e3e3e";
        description = ''
          Background color of the popup window, in hex color code.
        '';
      };

      borderColor = mkOption {
        type = types.str;
        default = "#ececec";
        description = ''
          Color of the popup window border, in hex color code.
        '';
      };

      fontColor = mkOption {
        type = types.str;
        default = "#ececec";
        description = ''
          Text color, in hex color code.
        '';
      };

      font = mkOption {
        type = types.str;
        default = "monospace";
        example = "DejaVu Sans:style=bold";
        description = ''
          Font to use, in fontconfig format.
        '';
      };

      fontSize = mkOption {
        type = types.int;
        default = 10;
        description = ''
          Font size.
        '';
      };

      lineSpacing = mkOption {
        type = types.int;
        default = 5;
        description = ''
          Space between consecutive lines.
        '';
      };

      padding = mkOption {
        type = types.int;
        default = 15;
        description = ''
          Space between text and border for all edges, in pixels.
        '';
      };

      width = mkOption {
        type = types.int;
        default = 450;
        description = ''
          Width of the popup window, in pixels.
        '';
      };

      borderSize = mkOption {
        type = types.str;
        default = 2;
        description = ''
          Border width, in pixels.
        '';
      };

      marginX = mkOption {
        type = types.int;
        default = 30;
        description = ''
          Horizontal distance the closest border of the screen.
        '';
      };

      marginY = mkOption {
        type = types.int;
        default = 60;
        description = ''
          Vertical distance from the closest border of the screen.
        '';
      };

      corner = mkOption {
        type = types.str;
        default = "top-right";
        description = ''
          Location of the popup window.
        '';
      };

      duration = mkOption {
        type = types.int;
        default = 5;
        description = ''
          Timeout in seconds.
        '';
      };
    };
  };

  config =
    let herbePackage = pkgs.herbe.override { config = cfg.settings; };
    in mkIf cfg.enable { home.packages = [ herbePackage ]; };
}
