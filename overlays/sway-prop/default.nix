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
  version = "unstable-2022-06-27";

  src = fetchurl {
    url = "https://gitlab.com/wef/dotfiles/-/raw/master/bin/sway-prop";
    sha256 = "0x6zilj5mpjykrkcqx6cj4hkk22ynpwc7rff4g2pwrs9963xq84m";
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
