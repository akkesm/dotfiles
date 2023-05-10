{ lib
, rustPlatform
, fetchFromGitHub
, moar
, less
}:

rustPlatform.buildRustPackage rec {
  pname = "riff";
  version = "2.23.3";

  src = fetchFromGitHub {
    owner = "walles";
    repo = pname;
    rev = version;
    sha256 = "0gii2dz6jh6lvr1mlk9wqby0igjb7933xd5jg1rpz8q5dbv90bg4";
  };

  cargoHash  = "sha256-c6Hgs8ordQtzmlywyuozpNZW8OjdQkjcRMQal7XdSv0=";

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
