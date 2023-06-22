{ lib
, stdenvNoCC
, fetchFromGitHub
}:

stdenvNoCC.mkDerivation {
  pname = "utterly-nord-solid-kvantum";
  version = "unstable-2023-02-15";

  src = fetchFromGitHub {
    owner = "HimDek";
    repo = "Utterly-Nord-Plasma";
    rev = "6d9ffe008f0bee47c8346c9a7ec71f206d999fd0";
    sha256 = "1kwhnq4j0llxibby2l3sfc9xl4xqn4plz2m5p3ji07q1bp0li6h7";
  };

  installPhase = ''
    runHook preInstall

    mkdir -p $out/share/Kvantum
    cp -a $src/kvantum-solid $out/share/Kvantum

    runHook postInstall
  '';

  meta = with lib; {
    description = "A solid Kvantum theme with dark Nordic Colors and round edges for UI elements";
    homepage = "https://store.kde.org/p/2011615";
    license = licenses.gpl2Only;
    platforms = platforms.linux;
    maintainers = with maintainers; [ akkesm ];
  };
}
