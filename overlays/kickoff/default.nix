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
  version = "0.5.0";

  src = fetchFromGitHub {
    owner = "j0ru";
    repo = "kickoff";
    rev = "v${version}";
    sha256 = "1gkgz6axh0yfs8rxxb1ybfiy9lna3z1icyiccqi1j8vxzswsc3yk";
  };

  cargoHash = "sha256-zyuBsqMPXUWXmhlMCuNJ/rIVuRumXGs1WVoM1cO0ouc=";

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
