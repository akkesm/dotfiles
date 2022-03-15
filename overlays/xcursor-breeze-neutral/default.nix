{ lib, stdenv, fetchFromGitHub }:

stdenv.mkDerivation {
  pname = "xcursor-breeze-neutral";
  version = "unstable-2019-02-02";

  src = fetchFromGitHub {
    owner = "TheScrawl";
    repo = "xcursor-breeze-neutral";
    rev = "f1f96240fa4e22c8701cf98c7afc92de8aec2b01";
    sha256 = "1vc11zwcl87qj0qgvp9kliq56zpsp8gis0ampvzkxk0d5mh4f20h";
  };

  installPhase = ''
    mkdir -p $out/share/icons
    cp -r ./cursors $out/share/icons
    install -D ./index.theme $out/share/icons
    install -D ./icon-theme.cache $out/share/icons
  '';

  meta = {
    description = " Neutral fork of KDE's Breeze Cursor";
    homepage = "https://github.com/TheScrawl/xcursor-breeze-neutral";
  };
}
