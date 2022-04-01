{ pkgs, ... }:

{
  programs.neovim.plugins = with pkgs.vimPlugins; [
      # {
      #   plugin = nvim-base16;
      #   config = ''
      #     colorscheme base16-nord
      #   '';
      # }

      {
        plugin = nord-nvim;
        type = "lua";
        config = ''
          vim.g.nord_borders = true
          vim.g.nord_italic = false
          require('nord').set()
        '';
      }
  ];
}
