{ stdenv
, lib
, fetchurl
, makeWrapper
, bash
, jq
, kitty
, sway
}:

stdenv.mkDerivation rec {
  pname = "sway-prop";
  version = "unstable-2021-11-02";

  src = fetchurl {
    url = "https://gitlab.com/wef/dotfiles/-/raw/master/bin/sway-prop";
    sha256 = "0i1zj9yjra5vlasbglskzyixbmzgwmsp4z5yb4mbffxmw8iifvi9";
    executable = true;
  };

  nativeBuildInputs = [ makeWrapper ];
  buildInputs = [ bash jq kitty sway ];

  dontUnpack = true;

  installPhase = ''
    mkdir -p $out/bin
    cp ${src} $out/bin/${pname}
    wrapProgram $out/bin/${pname} \
      --prefix PATH : ${lib.makeBinPath buildInputs}
  '';

  meta = {
    description = "Display information for the focused window in sway";
    license = lib.licenses.gpl3Plus;
    platforms = lib.platforms.linux;
  };
}
