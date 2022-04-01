{ ... }:

{
  imports = [
    ./auth.nix
    ./bash.nix
    ./gopass.nix
    ./gtk.nix
    ./kitty.nix
    ./qt.nix
    ./theme.nix
    ./applications
    ./desktop
    ./environment.nix
    ./media
    ./neovim
    ./terminal
    ./zsh
  ];

  home.stateVersion = "22.05";
}
