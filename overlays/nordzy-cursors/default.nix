{ lib, stdenv, fetchFromGitHub }:

stdenv.mkDerivation rec {
  pname = "nordzy-cursors";
  version = "0.1.0";

  src = fetchFromGitHub {
    owner = "alvatip";
    repo = "Nordzy-cursors";
    rev = "v${version}";
    sha256 = "1z34s81xa35f5s9k06vvh0glb33kwy9wwczajzbqw84ybhldz9jx";
  };

  installPhase = ''
    runHook preInstall

    mkdir -p $out/share/icons
    ls -l
    cp -r nordzy-dark/ $out/share/icons/nordzy-cursors
    cp -r nordzy-white/ $out/share/icons/nordzy-cursors-white

    runHook postInstall
  '';

  meta = with lib; {
    description = "Cursor theme using the Nord color palette";
    homepage = "https://github.com/alvatip/Nordzy-cursors";
    licenses = licenses.gpl3Only;
    platforms = platforms.linux;
  };
}
