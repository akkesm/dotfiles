{ lib
, stdenv
, fetchFromGitHub
, writeText
, pkg-config
, meson
, ninja
, cairo
, wayland
, wayland-protocols
, wayland-scanner

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
  # Convert a hex color code (eg. #3e3e3e) to RGB values from 0 to 1

  colorHexToRgbString = hexString:
    let
      hexToDec = h:
        let
          pow = base: exp:
            if exp == 0
            then 1
            else base * (pow base (exp - 1));
          toDecDigits = d:
            if (builtins.match "[0-9]" d) != null
            then lib.toInt d
            else {
              "A" = 10;
              "B" = 11;
              "C" = 12;
              "D" = 13;
              "E" = 14;
              "F" = 15;
            }.${lib.toUpper d};
          hexDigits = lib.flatten (builtins.filter builtins.isList (builtins.split "([[:xdigit:]])" h));
          decDigits = lib.imap1 (i: d: (toDecDigits d) * (pow 16 ((builtins.length hexDigits) - i))) hexDigits;
        in lib.foldl (a: b: a + b) 0 decDigits;
      hexPair = start: builtins.substring start 2 hexString;
      decInteger = start: hexToDec (hexPair start);
      hexPairToDecString = start: builtins.substring 0 5 (builtins.toString (decInteger start / 255.0));
      red = hexPairToDecString 1;
      green = hexPairToDecString 3;
      blue = hexPairToDecString 5 ;
    in { inherit red green blue; };

  mkConfigFile = config:
    let
      backgroundRgb = colorHexToRgbString config.backgroundColor;
      borderRgb = colorHexToRgbString config.borderColor;
      fontRgb = colorHexToRgbString config.fontColor;
    in
    writeText "herbe-config.h" ''
      #include <stdbool.h>
      #define LEFT ZWLR_LAYER_SURFACE_V1_ANCHOR_LEFT
      #define RIGHT ZWLR_LAYER_SURFACE_V1_ANCHOR_RIGHT
      #define TOP ZWLR_LAYER_SURFACE_V1_ANCHOR_TOP
      #define BOTTOM ZWLR_LAYER_SURFACE_V1_ANCHOR_BOTTOM

      // Style options
      static int32_t margin_right = ${builtins.toString config.marginRight};
      static int32_t margin_bottom = ${builtins.toString config.marginBottom};
      static int32_t margin_left = ${builtins.toString config.marginLeft};
      static int32_t margin_top = ${builtins.toString config.marginTop};
      // Where it shows up on screen for example top left would be LEFT+TOP or right top would be RIGHT+TOP, etc
      static uint32_t anchor = ${lib.toUpper (lib.concatStringsSep " + " (builtins.match "([a-zA-Z]+)[-_ ]([a-zA-Z]+)" config.corner))};
      static uint32_t width = ${builtins.toString config.width};
      static const unsigned int border_size = ${builtins.toString config.borderSize};
      // Backgound alpha
      static double alpha = ${lib.strings.floatToString config.backgroundAlpha};
      // Border alpha
      static double bralpha = ${lib.strings.floatToString config.borderAlpha};
      // Font alpha
      static double falpha = ${lib.strings.floatToString config.fontAlpha};
      static float font_size = ${lib.strings.floatToString config.fontSize};

      // Setting this to true makes it so windows will attempt to move out of the way for the notification
      static const bool exclusive_zone_on = ${if config.exclusiveZone then "true" else "false"};

      // These all accept a value of 0.0 to 1.0 for red, green, and blue. The last character corresponds to the color
      // Background color
      static const float bgr = ${backgroundRgb.red};
      static const float bgg = ${backgroundRgb.green};
      static const float bgb = ${backgroundRgb.blue};

      // Border color
      static const float brr = ${borderRgb.red};
      static const float brg = ${borderRgb.green};
      static const float brb = ${borderRgb.blue};

      // Font color
      static const float fr = ${fontRgb.red};
      static const float fg = ${fontRgb.green};
      static const float fb = ${fontRgb.blue};

      // Duration in seconds
      static const unsigned int duration = ${builtins.toString config.duration};
    '';

  configAttrs = {
    backgroundColor = "#3e3e3e";
    backgroundAlpha = 1.0;
    borderColor = "#ececec";
    borderAlpha = 1.0;
    fontColor = "#ececec";
    fontAlpha = 1.0;
    fontSize = 16.0;
    marginRight = 0;
    marginBottom = 0;
    marginLeft = 0;
    marginTop = 0;
    width = 450;
    borderSize = 2;
    corner = "top-right";
    exclusiveZone = true;
    duration = 5;
  } // config;

  configurationFile =
    if builtins.isPath configFile
    then configFile
    else mkConfigFile configAttrs;
in
stdenv.mkDerivation rec {
  pname = "wayherb-unstable";
  version = "2020-11-13";

  src = fetchFromGitHub {
    owner = "Vixeliz";
    repo = "Wayherb";
    rev = "fbcc7b265e72dc18202c2224dca224fd2f0868c6";
    sha256 = "1im4rngqqshxippml2jiif1s1na35swq5s1pkvsr1vx5zn6fjjcc";
  };

  nativeBuildInputs = [
    pkg-config
    meson
    ninja
    wayland-scanner
  ];

  buildInputs = [
    cairo
    wayland
    wayland-protocols
  ];

  mesonBuildType = "release";

  preBuild = ''
    rm ../include/config.h
    ln -s ${configurationFile} ../include/config.h
  '';

  meta = with lib; {
    description = "Daemon-less notifications without D-Bus";
    homepage = "https://github.com/dudik/herbe";
    license = licenses.mit;
  };
}
