{ lib, stdenv, fetchFromGitHub }:

stdenv.mkDerivation rec {
  pname = "nordzy-cursors";
  version = "0.6.0";

  src = fetchFromGitHub {
    owner = "alvatip";
    repo = "Nordzy-cursors";
    rev = "v${version}";
    sha256 = "0q4ik5ci080z1grf422b9bpwrgh8rv3sl6rca0y193ay5h9w9lxb";
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
