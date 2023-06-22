{ ... }:

{
  imports = [
    ./applications
    ./auth.nix
    ./bash.nix
    ./desktop
    ./environment.nix
    ./fonts.nix
    ./gopass.nix
    ./gtk.nix
    ./kitty.nix
    ./media
    ./neovim
    ./peripherals.nix
    ./qt.nix
    ./terminal
    ./zsh
  ];

  home.stateVersion = "22.11";
}
