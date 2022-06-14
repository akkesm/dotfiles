{ lib
, rustPlatform
, fetchFromGitHub
, cmake
, fontconfig
, pkg-config
, freetype
, expat
, makeFontsCache
}:

rustPlatform.buildRustPackage rec {
  pname = "kickoff";
  version = "0.5.1";

  src = fetchFromGitHub {
    owner = "j0ru";
    repo = "kickoff";
    rev = "v${version}";
    sha256 = "17jijz96m0b4h2al1r65igl86p3a0r4y6dfry204csgf56sfrxkm";
  };

  cargoSha256 = "0qmiyrqwbkjaz963as8l22i8z9ycz1zq3p204w94kzbw6baw95n0";

  nativeBuildInputs = [
    cmake
    fontconfig
    pkg-config
  ];

  buildInputs = [
    freetype
    expat
  ];

  FONTCONFIG_FILE = makeFontsCache { fontDirectories = [ ]; };

  meta = {
    description = "Minimalistic program launcher";
    homepage = "https://github.com/j0ru/kickoff";
    license = lib.licenses.gpl3Plus;
    platforms = lib.platforms.linux;
  };
}
