{ inputs }:

final: prev:

let
  inherit (final) callPackage;
in
{
  # New packages
  kickoff = callPackage ./kickoff { }; # Broken, fontconfig too old
  nordzy-cursors = callPackage ./nordzy-cursors { };
  nordzy-icon-theme = callPackage ./nordzy-icon-theme { };
  sway-launcher-desktop = callPackage ./sway-launcher-desktop { };
  xcursor-breeze-neutral = callPackage ./xcursor-breeze-neutral { };
  yaml-language-server = callPackage ./yaml-language-server { };

  ## scripts
  rwhich = callPackage ./rwhich { };

  # Package set extensions
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

  # let
  #   base_kernel = prev.linux_latest;
  # in
  # final.recurseIntoAttrs (final.linuxKernel.packagesFor (base_kernel.override {
  #   version = "${base_kernel.version}-civetta";

  #   features = {
  #     iwlwifi = true;
  #     efiBootStub = true;
  #     ia32Emulation = true;
  #   };

  #   structuredExtraConfig = import ./kernel/civetta-config.nix {
  #     inherit (final) lib stdenv;
  #   };

  #   ignoreConfigErrors = true;
  # }));
  # final.recurseIntoAttrs (final.linuxKernel.packagesFor (final.linuxKernel.manualConfig {
  #   inherit (final) lib stdenv;
  #   inherit (base_kernel) src;
  #   version = "${base_kernel.version}-civetta";

  #   kernelPatches = [ {
  #     name = "patchFeatures";
  #     patch = null;
  #     features = {
  #       iwlwifi = true;
  #       efiBootStub = true;
  #       ia32Emulation = true;
  #     };
  #   } ];

  #   configfile = ./kernel/custom.config;
  #   allowImportFromDerivation = true;
  # }));
}
