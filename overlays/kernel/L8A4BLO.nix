{ lib, stdenv, base_kernel, ... }:

let
  structuredConfig = import ./structured-config.nix {
    libKernel = lib.kernel;
  };
in
base_kernel.override {
  version = "${base_kernel.version}-L8A4BLO";

  # kernelPatches = [{
  #   name = "patchFeatures";
  #   patch = null;
  #   features = {
  #     iwlwifi = true;
  #     efiBootStub = true;
  #     ia32Emulation = true;
  #   };
  # }];

  structuredExtraConfig = (with structuredConfig; lib.mkMerge [
    wifi
  ]) // (with lib.kernel; {
    DEFAULT_HOSTNAME = freeform "L8A4BLO";

    NET_VENDOR_REALTEK = yes;
    R8169 = yes;

    WLAN_VENDOR_INTEL = yes;
    IWLWIFI = module;
    IWLDVM = module;
    IWLMVM = module;
    IWLWIFI_DEVICE_TRACING = yes;

  });

  # ignoreConfigErrors = true;
}

# linuxKernel.manualConfig {
#   inherit lib stdenv;
#   inherit (base_kernel) src;
#   version = "${base_kernel.version}-L8A4BLO";
#
#   configfile = ./custom.config;
#   allowImportFromDerivation = true;
# }
