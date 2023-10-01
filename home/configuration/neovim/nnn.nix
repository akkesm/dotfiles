{ pkgs, ... }:

{
  programs.neovim = {
    extraPackages = with pkgs; [ nnn ];

    plugins = with pkgs.vimPlugins; [
      {
        plugin = nnn-nvim;
        type= "lua";
        config = ''
          require('nnn').setup {}
        '';
      }
    ];
  };
}
