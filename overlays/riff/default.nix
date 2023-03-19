{ lib
, rustPlatform
, fetchFromGitHub
, moar
, less
}:

rustPlatform.buildRustPackage rec {
  pname = "riff";
  version = "2.23.2";

  src = fetchFromGitHub {
    owner = "walles";
    repo = pname;
    rev = version;
    sha256 = "1samcsnpzhnvyg8dd97pswsrpaf6hmh5lgrjp2d8ngrnq9n92r30";
  };

  cargoHash  = "sha256-oNZFVLh7avEhwaVGFsdES/CcCuQKsCC+1f8iuqLg6KM=";

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
