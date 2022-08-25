{ inputs, lib }:

final: prev:

let
  inherit (final) callPackage;
in
{
  # New packages
  fritzbox-callmonitor = final.libsForQt5.callPackage ./fritzbox-callmonitor { };
  herbe = callPackage ./herbe { };
  kickoff = callPackage ./kickoff { }; # Broken, fontconfig too old
  nordzy-cursors = callPackage ./nordzy-cursors { };
  nordzy-icon-theme = callPackage ./nordzy-icon-theme { };
  sway-launcher-desktop = callPackage ./sway-launcher-desktop { };
  sway-prop = callPackage ./sway-prop { };
  wayherb = callPackage ./wayherb { };
  xcursor-breeze-neutral = callPackage ./xcursor-breeze-neutral { };

  ## scripts
  fs-diff = callPackage ./fs-diff { };
  rwhich = callPackage ./rwhich { };

  # Package set extensions
  perlPackages = prev.perlPackages // import ./perl-packages {
    inherit lib;
    inherit (final) fetchurl;
    inherit (prev) perlPackages;
  };

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
