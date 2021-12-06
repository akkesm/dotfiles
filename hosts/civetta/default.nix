{ config, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./amdgpu.nix
    ./android.nix
    ./bluetooth.nix
    ./boot.nix
    ./desktop.nix
    ./kernel.nix
    ./luks.nix
    ./networking.nix
    ./persistence.nix
    ./pipewire.nix
    ./power.nix
    ./printing.nix
    ./security.nix
    ./swap.nix
    ./users.nix
    ./virtualisation.nix
  ];

  system.stateVersion = "22.05";
}
