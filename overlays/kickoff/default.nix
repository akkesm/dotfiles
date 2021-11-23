{ lib, rustPlatform, fetchFromGitHub
, cmake, pkg-config, freetype, expat, makeFontsCache
}:

rustPlatform.buildRustPackage {
  pname = "kickoff";
  version = "0.4.5";

  src = fetchFromGitHub {
    owner = "j0ru";
    repo = "kickoff";
    rev = "v0.4.5";
    sha256 = "1iiqh7fvfn1ql026ja36pcl8625axmkmrfkgq2b4h3vqza6jrqzy";
  };

  cargoHash = "sha256-UN1lsFSP1jBMszYFtxXdjih1/8n1/mjYiIWhYLsmUyw=";

  nativeBuildInputs = [
    cmake
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
    license = lib.licenses.gpl3;
    platforms = lib.platforms.linux;
  };
}
