{ config, pkgs, ... }:

{
  programs.neovim = {
    extraPackages = [ pkgs.tree-sitter ];

    plugins = with pkgs.vimPlugins; [
      {
        plugin = nvim-treesitter.withPlugins (p: builtins.attrValues (p // {
          inherit (pkgs.tree-sitter-grammars) tree-sitter-norg-meta tree-sitter-norg-table;
        }));
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
