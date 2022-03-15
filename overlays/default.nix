{ inputs }:

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
  perlPackages = prev.perlPackages // callPackage ./perl-packages {
    inherit (final) lib fetchurl;
    inherit (prev) perlPackages;
  };

  vimPlugins = prev.vimPlugins // callPackage ./vim-plugins {
    inherit inputs;
    inherit (final) lib vimUtils;
  };

  # Overrides
  linux_civetta = callPackage ./kernel/civetta.nix {
    inherit (final) lib stdenv;
    base_kernel = prev.linux_latest;
  };

  linuxPackages_civetta = final.recurseIntoAttrs (final.linuxKernel.packagesFor final.linux_civetta);

  zig-master = (prev.zig.overrideAttrs (oldAttrs: {
    version = "master";
    src = inputs.zig;
  })).override { llvmPackages = prev.llvmPackages_latest; };
}
