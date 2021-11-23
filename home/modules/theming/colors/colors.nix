{ config, lib, pkgs, ... }:

let
  inherit (lib) mkOption mkEnableOtions types;
in
{
  options = {
    theme = mkOption {
      type = types.enum [ "nord" "warmSteel" "theDigitalLife" ];
      default = "nord";
      description = ''
        The global theme for this user.
      '';
    };

    enableDarkMode = mkEnableOtions "dark mode";
  };

  config = {
    colors = mkMerge [
      (mkIf config.theme == "nord" (import ./nord.nix))
      (mkIf config.theme == "warmSteel" (import ./warmSteel.nix))
      (mkIf config.theme == "theDigitalLife" (import ./theDigitalLife.nix))
    ];
  };
}
