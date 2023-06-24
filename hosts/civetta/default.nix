{ ... }:

{
  imports = [
    ./amdgpu.nix
    ./android.nix
    ./bluetooth.nix
    ./boot.nix
    ./desktop.nix
    ./filesystem.nix
    ./greetd.nix
    ./kernel.nix
    ./luks.nix
    ./networking.nix
    ./persistence.nix
    ./pipewire.nix
    ./power.nix
    ./printing.nix
    ./users.nix
    ./virtualisation.nix
    ./zram.nix
  ];

  nixpkgs.hostPlatform = "x86_64-linux";
  system.stateVersion = "22.11";
}
