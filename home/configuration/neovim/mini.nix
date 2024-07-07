{ pkgs, ... }:

{
  programs.neovim.plugins = with pkgs.vimPlugins; [
    {
      plugin = gitsigns-nvim;
      type = "lua";
      config = ''
        require('gitsigns').setup {}
      '';
    }

    {
      plugin = mini-nvim;
      type = "lua";
      config = ''
        require('mini.ai').setup {}

        require('mini.base16').setup {
          palette = {
            base00 = '#2E3440',
            base01 = '#3B4252',
            base02 = '#434C5E',
            base03 = '#4C566A',
            base04 = '#D8DEE9',
            base05 = '#E5E9F0',
            base06 = '#ECEFF4',
            base07 = '#8FBCBB',
            base08 = '#BF616A',
            base09 = '#D08770',
            base0A = '#EBCB8B',
            base0B = '#A3BE8C',
            base0C = '#88C0D0',
            base0D = '#81A1C1',
            base0E = '#B48EAD',
            base0F = '#5E81AC',
          }
        }

        require('mini.bracketed').setup {}
        require('mini.bufremove').setup {}
        require('mini.comment').setup {}
        require('mini.git').setup {}
        require('mini.jump').setup {}
        require('mini.jump2d').setup {}
        require('mini.pairs').setup {}
        require('mini.statusline').setup { set_vim_settings = false }
        require('mini.splitjoin').setup {}
        require('mini.trailspace').setup {}
        '';
    }
  ];
}
