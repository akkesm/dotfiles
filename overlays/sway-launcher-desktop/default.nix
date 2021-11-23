{ lib, stdenv, fetchFromGitHub }:

stdenv.mkDerivation {
  pname = "sway-launcher-desktop";
  version = "1.5.2";

  src = fetchFromGitHub {
    owner = "Biont";
    repo = "sway-launcher-desktop";
    rev = "v1.5.2";
    sha256 = "0hkcawjf1zfk8ppnd8m1hsj3f1q11mwmcxv3wvf3j69lbmxrmfag";
  };

  postPatch = ''
    patchShebangs sway-launcher-desktop.sh
  '';

  installPhase = ''
    install -D sway-launcher-desktop.sh $out/bin/sway-launcher-desktop
  '';

  meta = {
    description = "TUI Application launcher with Desktop Entry support";
    homepage = "https://github.com/Biont/sway-launcher-desktop";
    license = lib.licenses.gpl3;
    platforms = lib.platforms.linux;
  };
}
