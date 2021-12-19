{ lib
, stdenv
, fetchFromGitHub
, writeText
, xorg

  # Configuration as an attribute set,
  # see below for the format and the defaults.
  # Alternatively provide configFile
  # or set values in ~/.Xresources
  # https://github.com/dudik/herbe/pull/11
, config ? null

  # Configuration in a C header file,
  # see below for the format
, configFile ? null
}:

assert (config != null) -> configFile == null;
assert (configFile != null) -> config == null;

let
  mkConfigFile = config: writeText "herbe-config.h" ''
    static const char *background_color = "${config.backgroundColor}";
    static const char *border_color = "${config.borderColor}";
    static const char *font_color = "${config.fontColor}";
    static const char *font_pattern = "${config.font}:size=${builtins.toString config.fontSize}";
    static const unsigned line_spacing = ${builtins.toString config.lineSpacing};
    static const unsigned int padding = ${builtins.toString config.padding};

    static const unsigned int width = ${builtins.toString config.width};
    static const unsigned int border_size = ${builtins.toString config.borderSize};
    static const unsigned int pos_x = ${builtins.toString config.marginX};
    static const unsigned int pos_y = ${builtins.toString config.marginY};

    enum corners { TOP_LEFT, TOP_RIGHT, BOTTOM_LEFT, BOTTOM_RIGHT };
    enum corners corner = ${lib.toUpper (lib.concatStringsSep "_" (builtins.match "([a-zA-Z]+)[-_ ]([a-zA-Z]+)" config.corner))};

    static const unsigned int duration = ${builtins.toString config.duration}; /* in seconds */

    #define DISMISS_BUTTON Button1
    #define ACTION_BUTTON Button3
  '';

  configAttrs = {
    backgroundColor = "#3e3e3e";
    borderColor = "#ececec";
    fontColor = "#ececec";
    font = "monospace";
    fontSize = 10;
    lineSpacing = 5;
    padding = 15;
    width = 450;
    borderSize = 2;
    marginX = 30;
    marginY = 60;
    corner = "top-right";
    duration = 5;
  } // config;

  finalConfigurationFile =
    if builtins.isPath configFile
    then configFile
    else mkConfigFile configAttrs;
in
stdenv.mkDerivation rec {
  pname = "herbe";
  version = "1.0.0";

  src = fetchFromGitHub {
    owner = "dudik";
    repo = pname;
    rev = version;
    sha256 = "0358i5jmmlsvy2j85ij7m1k4ar2jr5lsv7y1c58dlf9710h186cv";
  };

  buildInputs = [
    xorg.libX11
    xorg.libXft
  ];

  makeFlags = [ "PREFIX=$(out)" ];

  configurePhase = ''
    runHook preconfig

    substituteInPlace Makefile \
      --replace "cp config.def.h config.h" "cp ${finalConfigurationFile} config.h"

    runHook postConfig
  '';

  meta = with lib; {
    description = "Daemon-less notifications without D-Bus";
    homepage = "https://github.com/dudik/herbe";
    license = licenses.mit;
  };
}
