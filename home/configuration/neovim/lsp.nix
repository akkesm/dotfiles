{ config, pkgs, ... }:

{
  programs.neovim = {
    extraPackages = with pkgs; [
      ccls
      clojure-lsp
      gopls
      haskellPackages.haskell-language-server
      luajitPackages.lua-lsp
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
      perlPackages.Perl-LanguageServer
      rnix-lsp
      rust-analyzer-unwrapped
      scry
      solargraph
      sqls
      sumneko-lua-language-server
      terraform-ls
      texlab
      yaml-language-server
      zls
    ];

    plugins = with pkgs.vimPlugins; [
      # Completion
      {
        plugin = coq_nvim;
        config = ''
          let g:coq_settings = {
          \ 'xdg': v:true,
          \ 'auto_start': 'shut-up',
          \ 'match.fuzzy_cutoff': 0.9
          \ }
        '';
      }

      coq_artifacts

      {
        plugin = coq_thirdparty;
        config = ''
          lua << EOF
          require('coq_3p') {
            {
              src = 'bc',
              short_name = 'BC',
              precision = 6
            },
            {
              src = 'repl',
              sh = 'zsh',
              shell = {
                n = 'node',
                p = 'perl',
                r = 'ruby'
              },
              max_lines = 99,
              deadline = 500,
              unsafe = { 'rm', 'poweroff', 'mv', 'reboot' }
            },
            {
              src = 'nvimlua',
              short_name = 'nLUA',
              conf_only = true
            },
            {
              src = "vimtex",
              short_name = "vTEX"
            }
          }
          EOF
        '';
      }

      # Servers
      {
        plugin = nvim-lspconfig;
        config = ''
          lua << EOF
          local lspconfig = require('lspconfig')
          local coq = require('coq')
          lspconfig.bashls.setup(coq.lsp_ensure_capabilities({}))
          lspconfig.ccls.setup(coq.lsp_ensure_capabilities({
            root_dir = lspconfig.util.root_pattern('compile_commands.json', '.ccls', 'compile_flags.txt', '.git', 'flake.nix') or lspconfig.util.path.dirname
          }))
          lspconfig.clojure_lsp.setup(coq.lsp_ensure_capabilities({
            root_dir = lspconfig.util.root_pattern('project.clj', 'deps.edn', 'build.boot', 'shadow-cljs.edn', '.git', 'flake.nix') or lspconfig.util.path.dirname
          }))
          -- lspconfig.diagnosticls.setup(coq.lsp_ensure_capabilities({}))
          lspconfig.dockerls.setup(coq.lsp_ensure_capabilities({
                root_dir = lspconfig.util.root_pattern('Dockerfile', '.git', 'flake.nix') or lspconfig.util.path.dirname
          }))
          lspconfig.gopls.setup(coq.lsp_ensure_capabilities({
            root_dir = lspconfig.util.root_pattern('go.mod', '.git', 'flake.nix') or lspconfig.util.path.dirname
          }))
          lspconfig.hls.setup(coq.lsp_ensure_capabilities({
            root_dir = lspconfig.util.root_pattern('*.cabal', 'stack.yaml', 'cabal.project', 'package.yaml', 'hie.yaml', '.git', 'flake.nix') or lspconfig.util.path.dirname
          }))

          -- not needed with coq
          -- vim.lsp.protocol.make_client_capabilities().textDocument.completion.completionItem.snippetSupport = true
          lspconfig.html.setup(coq.lsp_ensure_capabilities({
            capabilities = vim.lsp.protocol.make_client_capabilities(),
            cmd = { 'html-languageserver', '--stdio' }
          }))

          lspconfig.jsonls.setup(coq.lsp_ensure_capabilities({
            cmd = { 'json-languageserver', '--stdio' }
          }))
          lspconfig.nimls.setup(coq.lsp_ensure_capabilities({}))
          lspconfig.perlls.setup(coq.lsp_ensure_capabilities({}))
          lspconfig.pyright.setup(coq.lsp_ensure_capabilities({}))
          lspconfig.rnix.setup(coq.lsp_ensure_capabilities({}))
          lspconfig.scry.setup(coq.lsp_ensure_capabilities({
            root_dir = lspconfig.util.root_pattern('shard.yml', '.git', 'flake.nix') or lspconfig.util.path.dirname
          }))
          lspconfig.solargraph.setup(coq.lsp_ensure_capabilities({
            root_dir = lspconfig.util.root_pattern('Gemfile', '.git', 'flake.nix') or lspconfig.util.path.dirname
          }))
          lspconfig.sqls.setup(coq.lsp_ensure_capabilities({}))

          lspconfig.sumneko_lua.setup(coq.lsp_ensure_capabilities({
            cmd = {
              "${pkgs.sumneko-lua-language-server}/bin/lua-language-server",
              '-E',
              "${pkgs.sumneko-lua-language-server}/extras/main.lua"
            },
            settings = {
              Lua = {
                runtime = {
                  version = 'LuaJIT',
                  path = vim.split(package.path, ';')
                },
                diagnostics = {
                  globals = {
                  'vim'
                  }
                },
                workspace = {
                  library = {
                    [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                    [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true
                  }
                },
                telemetry = {
                  enable = false
                }
              }
            }
          }))

          lspconfig.terraformls.setup(coq.lsp_ensure_capabilities({
            root_dir = lspconfig.util.root_pattern('.terraform', '.git', 'flake.nix') or lspconfig.util.path.dirname
          }))

          lspconfig.texlab.setup(coq.lsp_ensure_capabilities({
            settings = {
              latex = {
                lint = {
                  onchange = true
                }
              }
            }
          }))

          lspconfig.tsserver.setup(coq.lsp_ensure_capabilities({
            root_dir = lspconfig.util.root_pattern('package.json', 'tsconfig.json', 'jsconfig.json', '.git', 'flake.nix')
          }))
          lspconfig.vimls.setup(coq.lsp_ensure_capabilities({}))
          lspconfig.yamlls.setup(coq.lsp_ensure_capabilities({}))
          lspconfig.zls.setup(coq.lsp_ensure_capabilities({
            root_dir = lspconfig.util.root_pattern('zls.json', '.git', 'flake.nix') or lspconfig.util.path.dirname
          }))
          EOF
        '';
      }

      {
        plugin = rust-tools-nvim;
        config = ''
          lua << EOF
          require('rust-tools').setup({
            tools = {
              autoSetHints = true,
              hover_with_actions = true,
              runnables = {
                use_telescope = true
              },
              inlay_hints = {
                show_parameter_hints = true,
                parameter_hints_prefix = '<-',
                other_hints_prefix  = '->'
              }
            }
          })
          EOF
        '';
      }

      zig-vim

      vim-vsnip
      vim-vsnip-integ
      trouble-nvim
    ];
  };
}
