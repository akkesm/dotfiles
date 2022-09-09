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
    ./qt.nix
    ./terminal
    ./zsh
  ];

  home.stateVersion = "22.11";
}
