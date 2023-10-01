{ pkgs, ... }:

{
  programs.neovim = {
    extraLuaPackages = ps: with ps; [ jsregexp ];

    plugins = with pkgs.vimPlugins; [
      luasnip
      cmp_luasnip

      cmp-buffer
      cmp-nvim-lsp
      cmp-path
      cmp-treesitter

      {
        plugin = nvim-cmp;
        type = "lua";
        config = ''
          local cmp = require('cmp')

          cmp.setup({
            snippet = {
              expand = function(args)
                require('luasnip').lsp_expand(args.body)
              end
            },
            mapping = cmp.mapping.preset.insert({
              ['<C-b>'] = cmp.mapping.scroll_docs(-4),
              ['<C-f>'] = cmp.mapping.scroll_docs(4),
              ['<C-Space>'] = cmp.mapping.complete(),
              ['<C-e>'] = cmp.mapping.abort(),
              ['<CR>'] = cmp.mapping.confirm({ select = true })
            }),
            sources = cmp.config.sources({
              { name = 'nvim_lsp' },
              { name = 'luasnip' },
              { name = 'treesitter' },
            }, {
              { name = 'buffer' }
            })
           })
        '';
      }

      {
        plugin = cmp-git;
        type = "lua";
        config = ''
          local cmp = require('cmp')

          cmp.setup.filetype('gitcommit', {
            sources = cmp.config.sources({
              { name = 'git' }
            }, {
              { name = 'buffer' }
            })
          })
        '';
      }

      {
        plugin = cmp-cmdline;
        type = "lua";
        config = ''
          local cmp = require('cmp')

          cmp.setup.cmdline('/', {
            mapping = cmp.mapping.preset.cmdline(),
            sources = {
              { name = 'buffer' }
            }
          })

          cmp.setup.cmdline(':', {
            mapping = cmp.mapping.preset.cmdline(),
            sources = cmp.config.sources {
              { name = 'path' }
            }, {
              { name = 'cmdline' },
            }
          })
        '';
      }
    ];
  };
}
