{config, ...}:

{
  imports = [
    ./environment.nix
    ./tools.nix
    ./bash.nix
    ./zsh/zsh.nix
    ./neovim/neovim.nix
  ];
}
