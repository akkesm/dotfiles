{ ... }:

{
  imports = [
    ./applications
    ./auth.nix
    ./bash.nix
    ./desktop
    ./environment.nix
    ./gopass.nix
    ./gtk.nix
    ./kitty.nix
    ./media
    ./neovim
    ./qt.nix
    ./terminal
    ./theme.nix
    ./zsh
  ];

  home.stateVersion = "22.11";
}
