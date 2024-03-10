{ lib, stdenv, fetchFromGitHub }:

stdenv.mkDerivation rec {
  pname = "nordzy-cursors";
  version = "1.0.0";

  src = fetchFromGitHub {
    owner = "alvatip";
    repo = "Nordzy-cursors";
    rev = version;
    sha256 = "12mpwmaf4jjbg09nzxb6dpj9pfbb1iq61c484f4cqf6jdkl9znim";
  };

  installPhase = ''
    runHook preInstall

    mkdir -p $out/share/icons
    cp -r themes/* $out/share/icons

    runHook postInstall
  '';

  meta = with lib; {
    description = "Cursor theme using the Nord color palette";
    homepage = "https://github.com/alvatip/Nordzy-cursors";
    license = licenses.gpl3Only;
    platforms = platforms.unix;
  };
}
