{ lib
, rustPlatform
, fetchFromGitHub
, moar
, less
}:

rustPlatform.buildRustPackage rec {
  pname = "riff";
  version = "2.23.0";

  src = fetchFromGitHub {
    owner = "walles";
    repo = pname;
    rev = version;
    sha256 = "011by3yhc7lq2fm4jaacaknyi1n3wbhc7s8mxjsk3zmd11pla19n";
  };

  cargoHash  = "sha256-IDhRpmCc/QItq0dynHm3GA2xIwCQhsqd1Vcxx9MbcV4=";

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
