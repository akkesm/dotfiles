{ config, ... }:

{
  imports = [
    ./auth.nix
    ./bash.nix
    ./gtk.nix
    ./kitty.nix
    ./qt.nix
    ./theme.nix
    ./applications
    ./desktop
    ./environment.nix
    ./neovim
    ./terminal
    ./zsh
  ];

  home.stateVersion = "22.05";
}
