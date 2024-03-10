{ ... }:

{
  imports = [
    ./applications
    ./auth.nix
    ./bash.nix
    # ./desktop
    ./environment.nix
    ./fonts.nix
    ./gopass.nix
    ./gtk.nix
    ./kitty.nix
    ./kubernetes
    ./media
    ./neovim
    ./peripherals.nix
    # ./qt.nix
    ./terminal
    ./zsh
  ];

  home.stateVersion = "24.05";
}
