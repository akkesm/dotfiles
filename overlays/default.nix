{ inputs }:

final: prev:

{
  # New packages
  kickoff = final.callPackage ./kickoff { }; # Broken, fontconfig too old
  nordzy-cursors = final.callPackage ./nordzy-cursors { };
  nordzy-icon-theme = final.callPackage ./nordzy-icon-theme { };
  sway-launcher-desktop = final.callPackage ./sway-launcher-desktop { };
  xcursor-breeze-neutral = final.callPackage ./xcursor-breeze-neutral { };

  # Package set extensions
  vimPlugins = prev.vimPlugins
    // final.callPackage ./vim-plugins {
      inherit inputs;
      inherit (final) lib vimUtils;
    };

  # Overrides
  linux_civetta = final.callPackage ./kernel {
    inherit (final) lib stdenv;
    base_kernel = prev.linux_latest;
  };

  linuxPackages_civetta = final.recurseIntoAttrs (final.linuxKernel.packagesFor final.linux_civetta);
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
