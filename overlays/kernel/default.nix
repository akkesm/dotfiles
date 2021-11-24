{ lib, stdenv, base_kernel }:

base_kernel.override {
  version = "${base_kernel.version}-civetta";

  # kernelPatches = [{
  #   name = "patchFeatures";
  #   patch = null;
  #   features = {
  #     iwlwifi = true;
  #     efiBootStub = true;
  #     ia32Emulation = true;
  #   };
  # }];

  structuredExtraConfig = import ./civetta-config.nix {
    inherit lib stdenv;
  };

  preferBuiltin = true;
  ignoreConfigErrors = true;
}

# linuxKernel.manualConfig {
#   inherit lib stdenv;
#   inherit (base_kernel) src;
#   version = "${base_kernel.version}-civetta";
# 
#   configfile = ./custom.config;
#   allowImportFromDerivation = true;
# }
