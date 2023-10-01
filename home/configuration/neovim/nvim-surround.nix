{ pkgs, ... }:

{
  programs.neovim.plugins = with pkgs.vimPlugins; [
    {
      plugin = nvim-surround;
      type = "lua";
      config = ''
        require('nvim-surround').setup {}
      '';
    }
  ];
}
