{ lib, stdenv, fetchFromGitHub }:

stdenv.mkDerivation rec {
  pname = "nordzy-cursors";
  version = "0.4.0";

  src = fetchFromGitHub {
    owner = "alvatip";
    repo = "Nordzy-cursors";
    rev = "v${version}";
    sha256 = "1drswkqbhl8fhr4g5m6d8gpg4p3gdk097xrnvyamah63w83rrknp";
  };

  installPhase = ''
    runHook preInstall

    mkdir -p $out/share/icons
    ls -l
    cp -r Nordzy-cursors $out/share/icons
    cp -r Nordzy-cursors-white $out/share/icons

    runHook postInstall
  '';

  meta = with lib; {
    description = "Cursor theme using the Nord color palette";
    homepage = "https://github.com/alvatip/Nordzy-cursors";
    licenses = licenses.gpl3Only;
    platforms = platforms.unix;
  };
}
