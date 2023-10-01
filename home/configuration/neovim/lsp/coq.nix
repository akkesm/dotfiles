{ config, pkgs, ... }:

let
  hls-exe = pkgs.writeScript "hls-exe" ''
    #!/bin/sh
    [ -x haskell-language-server ] && haskell-language-server "$@" || haskell-language-server-wrapper "$@"
  '';
in
{
  programs.neovim = {
    extraPackages = (with pkgs; [
      # coq
      sqlite
      universal-ctags

      # LSP servers
      ccls
      docker-compose-language-service
      elixir-ls
      gopls
      # haskellPackages.haskell-language-server # Provided per-project
      jdt-language-server
      lua-language-server
      marksman
      nil
      nimlsp
      perlPackages.PLS
      solargraph # provide rubocop per-project
      sqls
      terraform-ls
      texlab
      zls
    ]) ++ (with pkgs.nodePackages; [
      bash-language-server
      dockerfile-language-server-nodejs
      pyright
      typescript
      typescript-language-server
      vscode-css-languageserver-bin
      vscode-html-languageserver-bin
      vscode-json-languageserver-bin
      yaml-language-server
    ]);

    plugins = with pkgs.vimPlugins; [
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
            cmd = { '${pkgs.elixir-ls}/bin/elixir-ls' },
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

          lspconfig.nil_ls.setup(coq.lsp_ensure_capabilities {
            settings = { ['nil'] = {
                formatting = { command = { 'nixpkgs-fmt' } }
            }}
          })

          lspconfig.scry.setup(coq.lsp_ensure_capabilities {
            root_dir = lspconfig.util.root_pattern('shard.yml', '.git', 'flake.nix') or lspconfig.util.path.dirname
          })

          lspconfig.solargraph.setup(coq.lsp_ensure_capabilities {
            root_dir = lspconfig.util.root_pattern('Gemfile', '.git', 'flake.nix') or lspconfig.util.path.dirname
          })

          lspconfig.sqls.setup(coq.lsp_ensure_capabilities {})

          lspconfig.lua_ls.setup(coq.lsp_ensure_capabilities {
            settings = {
              Lua = {
                runtime = {
                  version = 'LuaJIT',
                  path = vim.split(package.path, ';'),
                },

                ['diagnostics.globals'] = { 'vim' },
                ['workspace.library'] = vim.api.nvim_get_runtime_file("", true),
                ['telemetry.enable'] = false,
              },
            },
          })

          lspconfig.terraformls.setup(coq.lsp_ensure_capabilities {})

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

      luasnip
      cmp_luasnip
      trouble-nvim
    ];
  };
}
