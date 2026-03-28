{ lib
, fetchurl
, appimageTools
}:

let
  pname = "weiqihub";
  version = "0.1.13";

  src = fetchurl {
    url = "https://github.com/ale64bit/WeiqiHub/releases/download/v${version}/WeiqiHub-v${version}-x86_64.AppImage";
    sha256 = "00c2sc5xb26ljp0i1c2y7i3wghpbyw84qzlmj3nfngnkfmzrcqzs";
  };

  appimageContents = appimageTools.extract {
    inherit pname version src;
  };
in
appimageTools.wrapType2 {
  inherit pname version src;

    extraPkgs = pkgs: with pkgs; [ libepoxy ];

  extraInstallCommands = ''
    mv $out/bin/${pname} $out/bin/wqhub
    install -m 444 -D ${appimageContents}/com.walruswq.wqhub.desktop $out/share/applications/${pname}.desktop
    install -m 444 -D ${appimageContents}/wqhub.png $out/share/icons/hicolor/512x512/apps/${pname}.png
  '';

  meta = with lib; {
    description = "Unified client to multiple Go servers and offline puzzle solving";
    homepage = "https://github.com/ale64bit/WeiqiHub";
    license = licenses.bsd3;
    platforms = [ "x86_64-linux" ];
    mainProgram = "wqhub";
  };
}

