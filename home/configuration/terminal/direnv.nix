{ config, ... }:

{
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  xdg.configFile."direnv/direnv.toml".text = ''
    [gloabl]
    strict_env = true
    warn_timeout = 0

    [whitelist]
    prefix = [ "/persist/dotfiles", "${config.home.homeDirectory}/git" ]
  '';
}
