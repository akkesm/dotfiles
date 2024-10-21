{ lib, stdenv, fetchFromGitHub }:

stdenv.mkDerivation rec {
  pname = "nordzy-cursors";
  version = "2.3.0";

  src = fetchFromGitHub {
    owner = "alvatip";
    repo = "Nordzy-cursors";
    rev = "v${version}";
    sha256 = "15ahcc9glv58cn6pa9sf0fp6yiiq4sbxyknsaywaqwch82bi4xfw";
  };

  installPhase = ''
    runHook preInstall

    mkdir -p $out/share/icons
    cp -r xcursors/* $out/share/icons
    cp -r hyprcursors/themes/* $out/share/icons

    runHook postInstall
  '';

  meta = with lib; {
    description = "Cursor theme using the Nord color palette and based on Vimix and cz-Viator";
    homepage = "https://github.com/alvatip/Nordzy-cursors";
    license = licenses.gpl3Only;
    platforms = platforms.unix;
  };
}
