{ inputs, lib }:

final: prev:

let
  inherit (final) callPackage;
in
{
  # New packages
  herbe = callPackage ./herbe { };
  nordzy-cursors = callPackage ./nordzy-cursors { };
  nordzy-icon-theme = callPackage ./nordzy-icon-theme { };
  px = callPackage ./px {
    inherit (final.python3Packages)
      buildPythonApplication
      pytest
      pytest-runner
      python-dateutil;
  };
  silent = callPackage ./silent { };
  sway-launcher-desktop = callPackage ./sway-launcher-desktop { };
  sway-prop = callPackage ./sway-prop { };
  utterly-nord-solid-kvantum = callPackage ./utterly-nord-solid-kvantum { };
  wayherb = callPackage ./wayherb { };
  xcursor-breeze-neutral = callPackage ./xcursor-breeze-neutral { };

  ## scripts
  fs-diff = callPackage ./fs-diff { };
  rwhich = callPackage ./rwhich { };

  # Package set extensions
  tree-sitter-grammars = prev.tree-sitter-grammars // import ./tree-sitter-grammars {
    inherit inputs lib;
    inherit (final) callPackage;
  };

  vimPlugins =
    let
      vimPluginsExtension = import ./vim-plugins {
        inherit inputs lib;
        inherit (final) rustPlatform vimUtils;
      };
    in
    prev.vimPlugins.extend (final: prev: vimPluginsExtension);

  # Overrides
  zig-master = (prev.zig.overrideAttrs (oldAttrs: {
    version = "master";
    src = inputs.zig;
  })).override { llvmPackages = prev.llvmPackages_latest; };
}
