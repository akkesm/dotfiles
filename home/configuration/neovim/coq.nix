{ config, pkgs, ... }:

let
  hls-exe = pkgs.writeScript "hls-exe" ''
    #!/bin/sh
    [ -x haskell-language-server ] && haskell-language-server "$@" || haskell-language-server-wrapper "$@"
  '';

  elixir_ls_1_14 = pkgs.elixir_ls.override { elixir = pkgs.elixir_1_14; };
in
{
  programs.neovim = {
    extraLuaPackages = with pkgs.lua51Packages; [ lua-lsp ];

    extraPackages = (with pkgs; [
      # coq
      sqlite
      universal-ctags

      # LSP servers
      ccls
      elixir_ls_1_14
      gopls
      # haskellPackages.haskell-language-server # Provided per-project
      jdt-language-server
      nimlsp
      perlPackages.PLS
      rnix-lsp
      scry
      solargraph # provide rubocop per-project
      sqls
      sumneko-lua-language-server
      texlab
      zls
    ]) ++ (with pkgs.nodePackages; [
      bash-language-server
      dockerfile-language-server-nodejs
      purescript-language-server
      pyright
      typescript
      typescript-language-server
      vscode-html-languageserver-bin
      vscode-json-languageserver-bin
      yaml-language-server
    ]);

    plugins = with pkgs.vimPlugins; [
      coq-artifacts
      {
        plugin = coq-thirdparty;
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
      #         return npairs.esc('<C-e>') .. npairs.autopairs_bs()
      #       else
      #         return npairs.autopairs_bs()
      #       end
      #     end
      #     -- vim.keymap.set('i', '<BS>', 'v:lua.MUtils.BS()', { expr = true, noremap = true, silent = true })
      #   '';
      # }
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

          lspconfig.dockerls.setup(coq.lsp_ensure_capabilities {
            root_dir = lspconfig.util.root_pattern('Dockerfile', '.git', 'flake.nix') or lspconfig.util.path.dirname
          })

          lspconfig.elixirls.setup(coq.lsp_ensure_capabilities {
            cmd = { '${elixir_ls_1_14}/bin/elixir-ls' },
            root_dir = lspconfig.util.root_pattern('mix.exs', '.git', 'flake.nix') or lspconfig.util.path.dirname
          })

          lspconfig.gopls.setup(coq.lsp_ensure_capabilities {
            root_dir = lspconfig.util.root_pattern('go.mod', '.git', 'flake.nix') or lspconfig.util.path.dirname
          })

          lspconfig.hls.setup(coq.lsp_ensure_capabilities {
            cmd = { '${hls-exe}', '--lsp' },
            root_dir = lspconfig.util.root_pattern('*.cabal', 'stack.yaml', 'cabal.project', 'package.yaml', 'hie.yaml', '.git', 'flake.nix') or lspconfig.util.path.dirname,
            setting = { haskell = { formattingProvider = "fourmolu" } }
          })

          lspconfig.html.setup(coq.lsp_ensure_capabilities {
            cmd = { 'html-languageserver', '--stdio' },
          })

          lspconfig.jdtls.setup(coq.lsp_ensure_capabilities {
            cmd = { "jdt-language-server", "-configuration", "${config.xdg.cacheHome}/jdtls/config", "-data", "${config.xdg.cacheHome}/jdtls/workspace" },
            root_dir = lspconfig.util.root_pattern({
              -- Single-module projects
             'build.xml', -- Ant
             'pom.xml', -- Maven
             'settings.gradle', -- Gradle
             'settings.gradle.kts', -- Gradle
              -- Multi-module projects
              'build.gradle',
              'build.gradle.kts',
              -- Nix
              'flake.nix',
            }) or lspconfig.util.path.dirname
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

          lspconfig.texlab.setup(coq.lsp_ensure_capabilities { ['settings.latex.lint.onchange'] = true })

          lspconfig.tsserver.setup(coq.lsp_ensure_capabilities {
            root_dir = lspconfig.util.root_pattern('package.json', 'tsconfig.json', 'jsconfig.json', '.git', 'flake.nix')
          })

          lspconfig.yamlls.setup(coq.lsp_ensure_capabilities {})

          lspconfig.zls.setup(coq.lsp_ensure_capabilities {
            root_dir = lspconfig.util.root_pattern('zls.json', '.git', 'flake.nix') or lspconfig.util.path.dirname
          })
        '';
      }

      nvim-jdtls
      zig-vim

      vim-vsnip
      vim-vsnip-integ
      trouble-nvim
    ];
  };
}
