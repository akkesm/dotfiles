{ config, pkgs, ... }:

{
  programs.neovim.plugins = with pkgs.vimPlugins; [
    {
      plugin = nvim-treesitter.withPlugins (_: pkgs.tree-sitter.allGrammars);
      config = ''
        lua << EOF
        require('nvim-treesitter.configs').setup({
          highlight = {
            enable = true
          },
          incremental_selection = {
            enable = true
          },
          indent = {
            enable = true
          }
        })
        EOF
      '';
    }

    {
      plugin = nvim-treesitter-refactor;
      config = ''
        lua << EOF
        require('nvim-treesitter.configs').setup({
          refactor = {
            highlight_definitions = {
              enable = true
            },
            highlight_current_scope = {
              enable = false
            }
          }
        })
        EOF
      '';
    }
    nvim-treesitter-textobjects
    nvim-treesitter-context
    playground
  ];
}
