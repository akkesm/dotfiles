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
  version = "1.7.0";

  src = fetchFromGitHub {
    owner = "Biont";
    repo = pname;
    rev = "v${version}";
    sha256 = "0vphplphxfbdiwq0yk8ph7zlwlnghisnbwqjx7k9h93cy8n4rzcn";
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
