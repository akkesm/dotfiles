{ pkgs, ... }:

{
  programs.neovim = {
    extraPackages = [ pkgs.tree-sitter ];

    plugins = with pkgs.vimPlugins; [
      {
        plugin = nvim-treesitter.withPlugins (p: [
          p.tree-sitter-bash
          p.tree-sitter-bibtex
          p.tree-sitter-c
          p.tree-sitter-cmake
          p.tree-sitter-comment
          p.tree-sitter-cpp
          p.tree-sitter-css
          p.tree-sitter-devicetree
          p.tree-sitter-dockerfile
          p.tree-sitter-embedded-template
          p.tree-sitter-go
          p.tree-sitter-html
          p.tree-sitter-http
          p.tree-sitter-java
          p.tree-sitter-javascript
          p.tree-sitter-jsdoc
          p.tree-sitter-json
          p.tree-sitter-json5
          p.tree-sitter-latex
          p.tree-sitter-llvm
          p.tree-sitter-lua
          p.tree-sitter-make
          p.tree-sitter-markdown
          p.tree-sitter-nix
          p.tree-sitter-norg
          p.tree-sitter-perl
          p.tree-sitter-php
          p.tree-sitter-python
          p.tree-sitter-query
          p.tree-sitter-regex
          p.tree-sitter-ruby
          p.tree-sitter-rust
          p.tree-sitter-scss
          p.tree-sitter-toml
          p.tree-sitter-typescript
          p.tree-sitter-vim
          p.tree-sitter-yaml
          p.tree-sitter-zig
        ] ++ (with pkgs.tree-sitter-grammars; [
          tree-sitter-norg-meta
          tree-sitter-norg-table
        ]));
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
