{ config, pkgs, ... }:

{
  programs.neovim = {
    extraLuaPackages = with pkgs.lua51Packages; [ lua-lsp ];

    extraPackages = with pkgs; [
      # coq
      sqlite
      universal-ctags

      # LSP servers
      ccls
      clojure-lsp
      gopls
      haskellPackages.haskell-language-server
      nimlsp
      nodePackages.bash-language-server
      # nodePackages.diagnostic-languageserver
      nodePackages.dockerfile-language-server-nodejs
      nodePackages.pyright
      nodePackages.typescript
      nodePackages.typescript-language-server
      nodePackages.vim-language-server
      nodePackages.vscode-html-languageserver-bin
      nodePackages.vscode-json-languageserver-bin
      nodePackages.yaml-language-server
      perlPackages.PLS
      rnix-lsp
      rust-analyzer-unwrapped
      scry
      solargraph
      sqls
      sumneko-lua-language-server
      terraform-ls
      texlab
      zls
    ];

    plugins = with pkgs.vimPlugins; [
      {
        plugin = nvim-compleet;
        type = "lua";
        config = ''
          local compleet = require('compleet')

          compleet.setup {
            ui = { menu = {
              anchor = 'match',
              autoshow = true,
            } },
            completion = { while_deleting = true },
            sources = { lipsum = { enable = true } },
          }

          local tab = function()
            return
              (compleet.is_menu_visible() and '<Plug>(compleet-next-completion)')
              or (compleet.has_completions() and '<Plug>(compleet-show-completions)')
              or '<Tab>'
          end

          local s_tab = function()
            return
              compleet.is_menu_visible()
              and '<Plug>(compleet-prev-completion)'
              or '<S-Tab>'
          end

          local right = function()
            return
              compleet.is_hint_visible()
              and '<Plug>(compleet-insert-hinted-completion)'
              or '<Right>'
          end

          local cr = function()
            return
              compleet.is_completion_selected()
              and '<Plug>(compleet-insert-selected-completion)'
              or '<CR>'
          end

          vim.keymap.set('i', '<Tab>', tab, { expr = true, remap = true, silent = true })
          vim.keymap.set('i', '<S-Tab>', s_tab, { expr = true, remap = true, silent = true })
          vim.keymap.set('i', '<Right>', right, { expr = true, remap = true, silent = true })
          vim.keymap.set('i', '<CR>', cr, { expr = true, remap = true, silent = true })
        '';
      }
      # {
      #   plugin = nvim-autopairs;
      #   type = "lua";
      #   config = ''
      #     local npairs = require('nvim-autopairs')

      #     npairs.setup {
      #       enable_check_bracket_line = false,
      #       map_bs = false,
      #       map_cr = false,
      #       check_ts = true,
      #     }

      #     vim.keymap.set('i', '<Esc>', [[pumvisible() ? '<C-e><Esc>' : '<Esc>']], { expr = true, noremap = true, silent = true })
      #     vim.keymap.set('i', '<C-c>', [[pumvisible() ? '<C-e><C-c>' : '<C-c>']], { expr = true, noremap = true, silent = true })
      #     vim.keymap.set('i', '<Tab>', [[pumvisible() ? '<C-n>' : '<Tab>']], { expr = true, noremap = true, silent = true })
      #     vim.keymap.set('i', '<S-Tab>', [[pumvisible() ? '<C-p>' : '<BS>']], { expr = true, noremap = true, silent = true })

      #     _G.MUtils = {}

      #     MUtils.CR = function()
      #       if vim.fn.pumvisible() ~= 0 then
      #         if vim.fn.complete_info({ 'selected' }).selected ~= -1 then
      #           return npairs.esc('<C-y>')
      #         else
      #           return npairs.esc('<C-e>') .. npairs.autopairs_cr()
      #         end
      #       else
      #         return npairs.autopairs_cr()
      #       end
      #     end

      #     vim.keymap.set('i', '<CR>', 'v:lua.MUtils.CR()', { expr = true, noremap = true, silent = true })

      #     MUtils.BS = function()
      #       if vim.fn.pumvisible() ~= 0 and vim.fn.complete_info({ 'mode' }).mode == 'eval' then
      #         return npairs.esc('<c-e>') .. npairs.autopairs_bs()
      #       else
      #         return npairs.autopairs_bs()
      #       end
      #     end

      #     vim.keymap.set('i', '<BS>', 'v:lua.MUtils.BS()', { expr = true, noremap = true,silent = true })
      #   '';
      # }
      {
        plugin = nvim-lspconfig;
        type = "lua";
        config = ''
          local lspconfig = require('lspconfig')
          -- local coq = require('coq')

          lspconfig.bashls.setup {}

          lspconfig.ccls.setup {
            root_dir = lspconfig.util.root_pattern('compile_commands.json', '.ccls', 'compile_flags.txt', '.git', 'flake.nix') or lspconfig.util.path.dirname
          }

          lspconfig.clojure_lsp.setup {
            root_dir = lspconfig.util.root_pattern('project.clj', 'deps.edn', 'build.boot', 'shadow-cljs.edn', '.git', 'flake.nix') or lspconfig.util.path.dirname
          }

          -- lspconfig.diagnosticls.setup {}
          lspconfig.dockerls.setup {
                root_dir = lspconfig.util.root_pattern('Dockerfile', '.git', 'flake.nix') or lspconfig.util.path.dirname
          }

          lspconfig.gopls.setup {
            root_dir = lspconfig.util.root_pattern('go.mod', '.git', 'flake.nix') or lspconfig.util.path.dirname
          }

          lspconfig.hls.setup {
            root_dir = lspconfig.util.root_pattern('*.cabal', 'stack.yaml', 'cabal.project', 'package.yaml', 'hie.yaml', '.git', 'flake.nix') or lspconfig.util.path.dirname
          }

          lspconfig.html.setup {
            capabilities = vim.lsp.protocol.make_client_capabilities(),
            cmd = { 'html-languageserver', '--stdio' },
          }

          lspconfig.jsonls.setup {
            cmd = { 'json-languageserver', '--stdio' }
          }

          lspconfig.nimls.setup {}
          lspconfig.perlpls.setup {}
          lspconfig.pyright.setup {}
          lspconfig.rnix.setup {}

          lspconfig.scry.setup {
            root_dir = lspconfig.util.root_pattern('shard.yml', '.git', 'flake.nix') or lspconfig.util.path.dirname
          }

          lspconfig.solargraph.setup {
            root_dir = lspconfig.util.root_pattern('Gemfile', '.git', 'flake.nix') or lspconfig.util.path.dirname
          }

          lspconfig.sqls.setup {}

          lspconfig.sumneko_lua.setup {
            cmd = {
              "${pkgs.sumneko-lua-language-server}/bin/lua-language-server",
              '-E',
              "${pkgs.sumneko-lua-language-server}/extras/main.lua",
            },
            settings = {
              Lua = {
                runtime = {
                  version = 'LuaJIT',
                  path = vim.split(package.path, ';'),
                },

                ['diagnostics.globals'] = { 'vim' },

                ['workspace.library'] = {
                    [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                    [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
                },
                ['telemetry.enable'] = false,
              },
            },
          }

          lspconfig.terraformls.setup {
            root_dir = lspconfig.util.root_pattern('.terraform', '.git', 'flake.nix') or lspconfig.util.path.dirname
          }

          lspconfig.texlab.setup { ['settings.latex.lint.onchange'] = true }

          lspconfig.tsserver.setup {
            root_dir = lspconfig.util.root_pattern('package.json', 'tsconfig.json', 'jsconfig.json', '.git', 'flake.nix')
          }

          lspconfig.vimls.setup {}
          lspconfig.yamlls.setup {}

          lspconfig.zls.setup {
            root_dir = lspconfig.util.root_pattern('zls.json', '.git', 'flake.nix') or lspconfig.util.path.dirname
          }
        '';
      }

      {
        plugin = rust-tools-nvim;
        type = "lua";
        config = ''
          require('rust-tools').setup {
            tools = {
              autoSetHints = true,
              hover_with_actions = true,
              ['runnables.use_telescope'] = true,

              inlay_hints = {
                show_parameter_hints = true,
                parameter_hints_prefix = '<-',
                other_hints_prefix  = '->'
              },
            },
          }
        '';
      }

      zig-vim

      vim-vsnip
      vim-vsnip-integ
      trouble-nvim
    ];
  };
}
