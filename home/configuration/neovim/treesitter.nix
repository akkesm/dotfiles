{ config, pkgs, ... }:

{
  programs.neovim = {
    extraPackages = [ pkgs.tree-sitter ];

    plugins = with pkgs.vimPlugins; [
      {
        plugin = nvim-treesitter.withPlugins (_: pkgs.tree-sitter.allGrammars);
        type = "lua";
        config = ''
          require('nvim-treesitter.configs').setup {
            highlight = { enable = true },
            incremental_selection = { enable = true },
            indent = { enable = true },

            refactor = {
              highlight_definitions = { enable = true },
              highlight_current_scope = { enable = false },
            },
          }
        '';
      }
  
      nvim-treesitter-refactor
      nvim-treesitter-context
    ];
  };
}
