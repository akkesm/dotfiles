{ lib, stdenv, fetchFromGitHub, gtk3, hicolor-icon-theme }:

stdenv.mkDerivation {
  pname = "nordzy-icon-theme";
  version = "2022-01-15";

  src = fetchFromGitHub {
    owner = "alvatip";
    repo = "Nordzy-icon";
    rev = "ee5d01733fb69c05f5f4531105036148c47f9419";
    sha256 = "19y52297cklpyjp474nxvwxxcqr39qydf237f38r3pfhkl2ly40x";
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
