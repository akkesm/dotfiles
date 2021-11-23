{ lib, mkDerivation, fetchFromGitHub
, qmake, qttools, wrapQtAppsHook
, cmake, ninja, qtbase
}:

mkDerivation {
  name = "fritzbox-callmonitor";
  version = "2.0.0";

  src = fetchFromGitHub {
    owner = "petermost";
    repo = "FritzBoxCallMonitor";

    # 2.0.1 has vcpkg
    rev = "f9fb7e3fb4c560f58563b2f7d24c4983f9049ecd";
    sha256 = "ebTqy+iHjNJ3CNcqN5zIXGTYBF4bx3oaIBr0ZVgHVG0=";

    # 2.0.0 does not have vcpkg
    # rev = "eb25a0949b0a96ea5bb5f862f7d5ee82b00c5696";
    # sha256 = "qUag8f7TWyP/ZECiVaLgS+XEBIgFdg4IzlpTA8OWBHI=";

    fetchSubmodules = true;
  };

  nativeBuildInputs = [ qmake qttools wrapQtAppsHook cmake ninja ];
  buildInputs = [ qtbase ];

  dontUseQmakeConfigure = true;

  postConfigure = ''
    echo "test"
    cat build/source/build/vcpkg-bootstrap.log
  '';

  cmakeFlags = [
    "-Wno-dev"
    "-DCMAKE_BUILD_TYPE=Release"
    "-DBUILD_SHARED_LIBS=OFF"
    "-DCMAKE_MAKE_PROGRAM=${ninja}/bin/ninja"
  ];

  meta = {
    description = "A small utility written in C++/Qt to show incoming calls from the Fritz!Box";
    homepage = "https://www.pera-software.com/html/software/fritzbox-callmonitor/fritzbox-callmonitor.html";
    license = lib.licenses.gpl3Only;
  };
}
