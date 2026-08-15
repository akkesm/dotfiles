{ pkgs, ... }:

{
  programs.neovim = {
    extraPackages = [ pkgs.tree-sitter ];

    plugins = with pkgs.vimPlugins; [
      {
        plugin = nvim-treesitter.withAllGrammars;
        type = "lua";
        config = ''
          require('nvim-treesitter').setup {
            highlight = { enable = true },
            incremental_selection = { enable = true },
            indent = { enable = true },

            refactor = {
              highlight_definitions = { enable = true },
              highlight_current_scope = { enable = false },
            },

            rainbow = { enable = true },
          }

          vim.api.nvim_create_autocmd('FileType', {
            pattern = { 'elixir' },
            callback = function() vim.treesitter.start() end,
          })
        '';
      }

      nvim-treesitter-context
      nvim-ts-context-commentstring
    ];
  };
}
