{ ... }:

{
  imports = [
    ./applications
    ./auth.nix
    ./bash.nix
    ./environment.nix
    ./fonts.nix
    ./gopass.nix
    ./gtk.nix
    ./kitty.nix
    ./kubernetes
    ./media
    ./neovim
    # ./qt.nix
    # ./sway
    ./terminal
    ./zsh
  ];

  home.stateVersion = "24.11";
}
