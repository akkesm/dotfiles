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
    # ./kmonad
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

  system.stateVersion = "22.11";
}
