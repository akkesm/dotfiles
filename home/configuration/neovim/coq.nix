{ pkgs, ... }:

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
      nodePackages.purescript-language-server
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
      coq_artifacts
      {
        plugin = coq_thirdparty;
        type = "lua";
        config = ''
          require('coq_3p') {
            {
              src = 'bc',
              short_name = 'BC',
              precision = 6,
            },
            {
              src = 'repl',
              sh = 'zsh',

              shell = {
                n = 'nix eval --expr',
                p = 'perl -E',
              },

              max_lines = 30,
              deadline = 500,
              unsafe = { 'cp', 'dd', 'mv', 'poweroff', 'reboot', 'rm' },
            },
            { src = 'nvimlua' },
            { src = 'vimtex' },
          }
        '';
      }
      {
        plugin = coq_nvim;
        type = "lua";
        config = ''
          vim.g.coq_settings = {
            xdg = true,
            auto_start = 'shut-up',
            ['match.fuzzy_cutoff'] = 0.9,

            ['keymap.recommended'] = false,
          }
        '';
      }

      {
        plugin = nvim-autopairs;
        type = "lua";
        config = ''
          local npairs = require('nvim-autopairs')

          npairs.setup {
            enable_check_bracket_line = false,
            map_bs = false,
            map_cr = false,
            check_ts = true,
          }

          vim.keymap.set('i', '<Esc>', [[pumvisible() ? '<C-e><Esc>' : '<Esc>']], { expr = true, noremap = true, silent = true })
          vim.keymap.set('i', '<C-c>', [[pumvisible() ? '<C-e><C-c>' : '<C-c>']], { expr = true, noremap = true, silent = true })
          vim.keymap.set('i', '<Tab>', [[pumvisible() ? '<C-n>' : '<Tab>']], { expr = true, noremap = true, silent = true })
          vim.keymap.set('i', '<S-Tab>', [[pumvisible() ? '<C-p>' : '<BS>']], { expr = true, noremap = true, silent = true })

          _G.MUtils = {}

          MUtils.CR = function()
            if vim.fn.pumvisible() ~= 0 then
              if vim.fn.complete_info({ 'selected' }).selected ~= -1 then
                return npairs.esc('<C-y>')
              else
                return npairs.esc('<C-e>') .. npairs.autopairs_cr()
              end
            else
              return npairs.autopairs_cr()
            end
          end
          vim.keymap.set('i', '<CR>', 'v:lua.MUtils.CR()', { expr = true, noremap = true, silent = true })

          MUtils.BS = function()
            if vim.fn.pumvisible() ~= 0 and vim.fn.complete_info({ 'mode' }).mode == 'eval' then
              return npairs.esc('<c-e>') .. npairs.autopairs_bs()
            else
              return npairs.autopairs_bs()
            end
          end
          vim.keymap.set('i', '<BS>', 'v:lua.MUtils.BS()', { expr = true, noremap = true, silent = true })
        '';
      }
      {
        plugin = nvim-lspconfig;
        type = "lua";
        config = ''
          local lspconfig = require('lspconfig')
          local coq = require('coq')

          lspconfig.bashls.setup(coq.lsp_ensure_capabilities {})

          lspconfig.ccls.setup(coq.lsp_ensure_capabilities {
            root_dir = lspconfig.util.root_pattern('compile_commands.json', '.ccls', 'compile_flags.txt', '.git', 'flake.nix') or lspconfig.util.path.dirname
          })

          lspconfig.clojure_lsp.setup(coq.lsp_ensure_capabilities {
            root_dir = lspconfig.util.root_pattern('project.clj', 'deps.edn', 'build.boot', 'shadow-cljs.edn', '.git', 'flake.nix') or lspconfig.util.path.dirname
          })

          -- lspconfig.diagnosticls.setup(coq.lsp_ensure_capabilities {})
          lspconfig.dockerls.setup(coq.lsp_ensure_capabilities {
                root_dir = lspconfig.util.root_pattern('Dockerfile', '.git', 'flake.nix') or lspconfig.util.path.dirname
          })

          lspconfig.gopls.setup(coq.lsp_ensure_capabilities {
            root_dir = lspconfig.util.root_pattern('go.mod', '.git', 'flake.nix') or lspconfig.util.path.dirname
          })

          lspconfig.hls.setup(coq.lsp_ensure_capabilities {
            root_dir = lspconfig.util.root_pattern('*.cabal', 'stack.yaml', 'cabal.project', 'package.yaml', 'hie.yaml', '.git', 'flake.nix') or lspconfig.util.path.dirname
          })

          lspconfig.html.setup(coq.lsp_ensure_capabilities {
            capabilities = vim.lsp.protocol.make_client_capabilities(),
            cmd = { 'html-languageserver', '--stdio' },
          })

          lspconfig.jsonls.setup(coq.lsp_ensure_capabilities {
            cmd = { 'json-languageserver', '--stdio' }
          })

          lspconfig.nimls.setup(coq.lsp_ensure_capabilities {})
          lspconfig.perlpls.setup(coq.lsp_ensure_capabilities {})
          lspconfig.purescriptls.setup(coq.lsp_ensure_capabilities {})
          lspconfig.pyright.setup(coq.lsp_ensure_capabilities {})
          lspconfig.rnix.setup(coq.lsp_ensure_capabilities {})

          lspconfig.scry.setup(coq.lsp_ensure_capabilities {
            root_dir = lspconfig.util.root_pattern('shard.yml', '.git', 'flake.nix') or lspconfig.util.path.dirname
          })

          lspconfig.solargraph.setup(coq.lsp_ensure_capabilities {
            root_dir = lspconfig.util.root_pattern('Gemfile', '.git', 'flake.nix') or lspconfig.util.path.dirname
          })

          lspconfig.sqls.setup(coq.lsp_ensure_capabilities {})

          lspconfig.sumneko_lua.setup(coq.lsp_ensure_capabilities {
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
          })

          lspconfig.terraformls.setup(coq.lsp_ensure_capabilities {
            root_dir = lspconfig.util.root_pattern('.terraform', '.git', 'flake.nix') or lspconfig.util.path.dirname
          })

          lspconfig.texlab.setup(coq.lsp_ensure_capabilities { ['settings.latex.lint.onchange'] = true })

          lspconfig.tsserver.setup(coq.lsp_ensure_capabilities {
            root_dir = lspconfig.util.root_pattern('package.json', 'tsconfig.json', 'jsconfig.json', '.git', 'flake.nix')
          })

          lspconfig.vimls.setup(coq.lsp_ensure_capabilities {})
          lspconfig.yamlls.setup(coq.lsp_ensure_capabilities {})

          lspconfig.zls.setup(coq.lsp_ensure_capabilities {
            root_dir = lspconfig.util.root_pattern('zls.json', '.git', 'flake.nix') or lspconfig.util.path.dirname
          })
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
