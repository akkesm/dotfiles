{ lib, stdenv, fetchFromGitHub }:

stdenv.mkDerivation rec {
  pname = "nordzy-cursors";
  version = "0.3.0";

  src = fetchFromGitHub {
    owner = "alvatip";
    repo = "Nordzy-cursors";
    rev = "v${version}";
    sha256 = "1swc2c0gjz2q5div6d597vr2mncw3sc864lcdw658y15k64sa3yi";
  };

  installPhase = ''
    runHook preInstall

    mkdir -p $out/share/icons
    ls -l
    cp -r Nordzy-cursors/ $out/share/icons/nordzy-cursors
    cp -r Nordzy-cursors-white/ $out/share/icons/nordzy-cursors-white

    runHook postInstall
  '';

  meta = with lib; {
    description = "Cursor theme using the Nord color palette";
    homepage = "https://github.com/alvatip/Nordzy-cursors";
    licenses = licenses.gpl3Only;
    platforms = platforms.linux;
  };
}
