{ pkgs, ... }:

{
  programs.neovim = {
    extraPackages = with pkgs; [
      fd
      ripgrep
    ];

    plugins = with pkgs.vimPlugins; [
      {
        plugin = telescope-nvim;
        type = "lua";
        config = ''
          require('telescope').setup {}

          vim.keymap.set('n', '<Leader>ff', function() return require('telescope.builtin').find_files() end, { noremap = true })
          vim.keymap.set('n', '<Leader>fg', function() return require('telescope.builtin').live_grep() end, { noremap = true })
          vim.keymap.set('n', '<Leader>fb', function() return require('telescope.builtin').buffers() end, { noremap = true })
          vim.keymap.set('n', '<Leader>fh', function() return require('telescope.builtin').help_tags() end, { noremap = true })
        '';
      }

      popup-nvim

      {
        plugin = telescope-fzf-native-nvim;
        type = "lua";
        config = ''
          require('telescope').load_extension('fzf')
        '';
      }
    ];
  };
}
