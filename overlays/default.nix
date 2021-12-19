{ inputs }:

final: prev:

let
  inherit (final) callPackage;
in
{
  # New packages
  herbe = callPackage ./herbe { };
  kickoff = callPackage ./kickoff { }; # Broken, fontconfig too old
  nordzy-cursors = callPackage ./nordzy-cursors { };
  nordzy-icon-theme = callPackage ./nordzy-icon-theme { };
  sway-launcher-desktop = callPackage ./sway-launcher-desktop { };
  wayherb = callPackage ./wayherb { };
  xcursor-breeze-neutral = callPackage ./xcursor-breeze-neutral { };
  yaml-language-server = callPackage ./yaml-language-server { };

  ## scripts
  fs-diff = callPackage ./fs-diff { };
  rwhich = callPackage ./rwhich { };

  # Package set extensions
  # perlPackages = prev.perlPackages // callPackage ./perl-packages {
  #   inherit (final) lib fetchurl;
  #   inherit (prev) perlPackages;
  # };

  vimPlugins = prev.vimPlugins // callPackage ./vim-plugins {
    inherit inputs;
    inherit (final) lib vimUtils;
  };

  # Overrides
  # linux_civetta = callPackage ./kernel/civetta.nix {
  #   inherit (final) lib stdenv;
  #   base_kernel = prev.linux_latest;
  # };

  # linuxPackages_civetta = final.recurseIntoAttrs (final.linuxKernel.packagesFor final.linux_civetta);
}
