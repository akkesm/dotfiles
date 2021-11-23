{ linux_latest, pkg-config, ncurses }:

linux_latest.overrideAttrs (oldAttrs: {
  nativeBuildInputs = oldAttrs.nativeBuildInputs ++ [
    pkg-config
    ncurses
  ];

  shellHook = ''
    # pushd $(mktemp -d)
    unpackPhase
    cd linux-*
    patchPhase
    make nconfig
  '';
})
