{ lib, stdenv, fetchFromGitHub, gtk3, hicolor-icon-theme }:

stdenv.mkDerivation rec {
  pname = "nordzy-icon-theme";
  version = "1.7";

  src = fetchFromGitHub {
    owner = "alvatip";
    repo = "Nordzy-icon";
    rev = version;
    sha256 = "0h6fsaihfl4cjava2fiy4hy7yb2c0svnpz5df710xapdzqf889d7";
  };

  nativeBuildInputs = [ gtk3 ];

  propagatedBuildInputs = [ hicolor-icon-theme ];

  dontDropIconThemeCache = true;
  dontPatchELF = true;
  dontRewriteSymlinks = true;

  postPatch = ''
    patchShebangs install.sh

    sed -i '/^ascii_art$/d' install.sh
  '';

  installPhase = ''
    runHook preInstall

    mkdir -p $out/share/icons

    ./install.sh \
      --dest $out/share/icons \
      --name 'Nordzy' \
      --theme all

    runHook postInstall
  '';

  meta = with lib; {
    description = "Icon theme using the Nord color palette";
    longDescription = ''
      Nordzy is a free and open source icon theme for Linux desktops using the Nord color palette from Arctic Ice Studio and based on WhiteSur Icon Theme and Numix Icon Theme
    '';
    homepage = "https://github.com/alvatip/Nordzy-icon";
    license = licenses.gpl3Only;
    platforms = platforms.linux;
  };
}
