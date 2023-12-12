{ stdenv
, lib
, fetchurl
, makeWrapper
, bash
, i3
, sway
, alacritty
, jq
}:

stdenv.mkDerivation rec {
  pname = "i3-prop";
  version = "unstable-2023-11-29";

  src = fetchurl {
    url = "https://gitlab.com/wef/dotfiles/-/raw/ffffd5b55a96eeb64febe50a0f5c6859de9e6f55/bin/i3-prop";
    sha256 = "1chfywajcm7xarc3h1a2s312ad193a8i0qnckkmh2dskbsr1h0rv";
    executable = true;
  };

  nativeBuildInputs = [ makeWrapper ];
  buildInputs = [ bash i3 sway alacritty jq ];

  dontUnpack = true;

  installPhase = ''
    mkdir -p $out/bin
    cp ${src} $out/bin/${pname}
    wrapProgram $out/bin/${pname} --prefix PATH : ${lib.makeBinPath buildInputs}
  '';

  meta = {
    description = "Display information for the focused window in i3/Sway";
    license = lib.licenses.gpl3Plus;
    platforms = lib.platforms.linux;
  };
}
