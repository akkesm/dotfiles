{ lib
, mkDerivation
, fetchFromGitHub
, qmake
, qttools
, wrapQtAppsHook
, cmake
, ninja
, gtest
, qtbase
}:

mkDerivation {
  name = "fritzbox-callmonitor";
  version = "2.0.0";

  src = fetchFromGitHub {
    owner = "petermost";
    repo = "FritzBoxCallMonitor";

    # 2.0.1 has vcpkg
    rev = "f9fb7e3fb4c560f58563b2f7d24c4983f9049ecd";
    sha256 = "0val0xc6bx0s40d7miqvbq2dhr2wr2f3fanp11vx5347x35ymd3r";

    # 2.0.0 does not have vcpkg
    # rev = "eb25a0949b0a96ea5bb5f862f7d5ee82b00c5696";
    # sha256 = "0wh4jv1h6lssrq40wxh5i02c9rabw2i5b8j0ckzj6nykzvqs0im9";

    fetchSubmodules = true;
  };

  nativeBuildInputs = [
    qmake
    qttools
    wrapQtAppsHook
    cmake
    ninja
  ];

  buildInputs = [
    gtest
    qtbase
  ];

  cmakeFlags = [
    "-DDISABLE_VCPKG=TRUE"
    "-DDISABLE_SENTRY=TRUE"
    "-DDISABLE_CRASH_LOG=TRUE"
    "-Wno-dev"
    "-DCMAKE_BUILD_TYPE=Release"
    "-DBUILD_SHARED_LIBS=OFF"
    "-DCMAKE_MAKE_PROGRAM=${ninja}/bin/ninja"
  ];

  dontUseQmakeConfigure = true;

  meta = {
    description = "A small utility written in C++/Qt to show incoming calls from the Fritz!Box";
    homepage = "https://www.pera-software.com/html/software/fritzbox-callmonitor/fritzbox-callmonitor.html";
    license = lib.licenses.gpl3Only;
  };
}
