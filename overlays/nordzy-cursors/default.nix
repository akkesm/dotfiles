{ lib, stdenv, fetchFromGitHub }:

stdenv.mkDerivation rec {
  pname = "nordzy-cursors";
  version = "0.5.0";

  src = fetchFromGitHub {
    owner = "alvatip";
    repo = "Nordzy-cursors";
    rev = "v${version}";
    sha256 = "1xjq23pnanbkd1bfyl434ssm7s0h6izhw76ywgillvybr7bvqrx7";
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
