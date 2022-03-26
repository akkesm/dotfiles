{ config, pkgs, ... }:

{
  boot.initrd.kernelModules = [ "amdgpu" ];
  environment.sessionVariables.LIBVA_DRIVE_NAME = "radeonsi";

  hardware.opengl = {
    enable = true;
    driSupport = true;

    # Cannot set the kernel feature with manualConfig
    # here it is checked
    driSupport32Bit = true;

    extraPackages = with pkgs; [
      rocm-opencl-icd
      rocm-opencl-runtime
      amdvlk
    ];

    extraPackages32 = [
      pkgs.driversi686Linux.amdvlk
    ];
  };
}
