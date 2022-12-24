{ lib
, rustPlatform
, fetchFromGitHub
, moar
, less
}:

rustPlatform.buildRustPackage rec {
  pname = "riff";
  version = "2.22.2";

  src = fetchFromGitHub {
    owner = "walles";
    repo = pname;
    rev = version;
    sha256 = "09sq0q0fh9xl64y7gx53nhqih94hjgpkahwpg0fp9f6p1s12jgsx";
  };

  cargoSha256 = "0j1jphw6zpfmrrlgdsaqf61j3ly3hjhbv7yyxxzmq44zfyxih65l";

  buildInputs = [
    # diffutils
    moar
    less
  ];

  meta = with lib; {
    description = "A diff filter highlighting which line parts have changed";
    homepage = "https://github.com/walles/riff";
    license = licenses.mit;
    platform = platforms.unix;
  };
}
