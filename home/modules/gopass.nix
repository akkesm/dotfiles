{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.programs.gopass;
  yamlFormat = pkgs.formats.yaml { };
in
{
  options.programs.gopass = {
    enable = mkEnableOption "Gopass";

    package = mkOption {
      type = types.package;
      default = pkgs.gopass;
      defaultText = literalExpression "pkgs.gopass";
      description = ''
        The gopass package to use.
      '';
    };

    variables = mkOption rec {
      type = with types; attrsOf str;
      apply = mergeAttrs default;
      default = { GOPASS_CONFIG = "${config.xdg.configHome}/gopass/config.yaml"; };
      defaultText = literalExpression ''
        { GOPASS_CONFIG = "${config.xdg.configHome}/gopass/config.yaml"; }
      '';
      example = literalExpression ''
        {
          GOPASS_CONFIG = "${config.home.homeDirectory}/.config/gopass.yml";
          CHECKPOINT_DISABLE = "true";
        }
      '';
      description = ''
        The <literal>gopass</literal> environment variables dictionary.
        See <link xlink:href="https://github.com/gopasspw/gopass/blob/master/docs/config.md#environment-variables" /> for the full
        list of options.
      '';
    };

    settings = mkOption {
      type = yamlFormat.type;
      default = { };
      example = literalExpression ''
        {
          autoclip = true;
          cliptimeout = 30;
           path = "${config.xdg.dataHome}/password-store";
        }
      '';
      description = ''
        Configuration written to
        <filename>$XDG_CONFIG_HOME/gopass/config.yaml</filename>.
        See <link xlink:href="https://github.com/gopasspw/gopass/blob/master/docs/config.md#configuration-options" /> for the full
        list of options.
      '';
    };
  };

  config = mkIf cfg.enable {
    home.packages = [ cfg.package ];
    home.sessionVariables = cfg.variables;

    xsession.importedVariables = mkIf config.xsession.enable
      (mapAttrsToList (name: value: name) cfg.variables);

    xdg.configFile."${cfg.variables.GOPASS_CONFIG}" = mkIf (cfg.settings != { }) {
      source = yamlFormat.generate "gopass-config.yaml" cfg.settings;
    };
  };
}
