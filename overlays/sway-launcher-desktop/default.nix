{ lib
, stdenv
, fetchFromGitHub
, makeWrapper
, bash
, coreutils
, fzf
, gawk
, man-db
}:

stdenv.mkDerivation rec {
  pname = "sway-launcher-desktop";
  version = "1.5.4";

  src = fetchFromGitHub {
    owner = "Biont";
    repo = pname;
    rev = "v${version}";
    sha256 = "0i19igj30jyszqb63ibq0b0zxzvjw3z1zikn9pbk44ig1c0v61aa";
  };

  buildInputs = [
    makeWrapper
    coreutils
    fzf
    gawk
    man-db
  ];

  dontPatchSheBangs = true;

  installPhase = ''
    install -D sway-launcher-desktop.sh $out/bin/sway-launcher-desktop
  '';

  fixupPhase = ''
    wrapProgram $out/bin/sway-launcher-desktop \
      --prefix PATH : ${lib.makeBinPath [ bash coreutils fzf gawk man-db ]}
  '';

  meta = {
    description = "TUI Application launcher with Desktop Entry support";
    homepage = "https://github.com/Biont/sway-launcher-desktop";
    license = lib.licenses.gpl3;
    platforms = lib.platforms.linux;
  };
}
