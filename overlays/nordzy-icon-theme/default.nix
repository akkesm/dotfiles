{ lib, stdenv, fetchFromGitHub, gtk3, hicolor-icon-theme }:

stdenv.mkDerivation {
  pname = "nordzy-icon-theme";
  version = "2021-10-31";

  src = fetchFromGitHub {
    owner = "alvatip";
    repo = "Nordzy-icon";
    rev = "07ee8500d391d6669849dac5c345fac2ec55041f";
    sha256 = "1ghmdj5ial7wj3dz622zkv6n452xgp8qbkp81rjfhsr57y4jg8aq";
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
