{ pkgs, ... }:

let
  hls-cmd = pkgs.writeScript "hls-cmd" ''
    #!/bin/sh

    [ -x haskell-language-server ] \
      && haskell-language-server "$@" \
      || haskell-language-server-wrapper "$@"
  '';
in
{
  programs.neovim = {
    extraPackages = (with pkgs; [
      ccls
      docker-compose-language-service
      elixir-ls
      gopls
      jdt-language-server
      lua-language-server
      marksman
      nil nixpkgs-fmt
      nimlsp
      perlPackages.PLS
      pyright
      solargraph rubocop
      sqls
      terraform-ls
      texlab
      zls
    ]) ++ (with pkgs.haskellPackages; [
      haskell-language-server hls-cmd fourmolu
    ]) ++ (with pkgs.nodePackages; [
      bash-language-server
      dockerfile-language-server-nodejs
      typescript-language-server typescript
      vscode-langservers-extracted
      yaml-language-server
    ]);

    plugins = with pkgs.vimPlugins; [
      {
        plugin = nvim-lspconfig;
        type = "lua";
        config = ''
          local capabilities = require('cmp_nvim_lsp').default_capabilities()

          vim.lsp.config.bashls.setup { capabilities = capabilities }
          vim.lsp.config.ccls.setup {
            capabilities = capabilities,
            root_dir = vim.lsp.config.util.root_pattern('compile_commands.json', '.ccls', '.git', 'Makefile', 'flake.nix'),
            single_file_support = true,
          }

          vim.lsp.config.cssls.setup { capabilities = capabilities }

          vim.lsp.config.docker_compose_language_service.setup {
            capabilities = capabilities,
            filetypes = {
              'yaml',
              'yaml.docker-compose',
            },
          }

          vim.lsp.config.dockerls.setup { capabilities = capabilities }

          vim.lsp.config.elixirls.setup {
            capabilities = capabilities,
            cmd = { '${pkgs.elixir-ls}/bin/elixir-ls' },
          }

          vim.lsp.config.gopls.setup { capabilities = capabilities }

          vim.lsp.config.hls.setup {
              capabilities = capabilities,
              cmd = { '${hls-cmd}', '--lsp' },
              setting = { haskell = { formattingProvider = 'fourmolu' } },
          }

          vim.lsp.config.html.setup {
            capabilities = capabilities,
            cmd = { '${pkgs.nodePackages.vscode-langservers-extracted}/bin/vscode-html-languageserver', '--stdio' },
          }

          vim.lsp.config.jdtls.setup { capabilities = capabilities }

          vim.lsp.config.jsonls.setup {
            capabilities = capabilities,
            cmd = { '${pkgs.nodePackages.vscode-langservers-extracted}/bin/vscode-json-languageserver', '--stdio' },
          }

          vim.lsp.config.lua_ls.setup {
            capabilities = capabilities,
            on_init = function(client)
              local path = client.workspace_folders[1].name
              if not vim.loop.fs_stat(path..'/.luarc.json') and not vim.loop.fs_stat(path..'/.luarc.jsonc') then
                client.config.settings = vim.tbl_deep_extend('force', client.config.settings.Lua, {
                  runtime = { version = 'LuaJIT' },
                  workspace = { library = { vim.env.VIMRUNTIME } },
                })

                client.notify('workspace/didChangeConfiguration', { settings = client.config.settings })
              end
              return true
            end,
          }

          vim.lsp.config.marksman.setup { capabilities = capabilities }

          vim.lsp.config.nil_ls.setup {
              capabilities = capabilities,
              settings = { ['nil'] = { formatting = { command = { 'nixpkgs-fmt' } } } },
          }

          vim.lsp.config.nimls.setup { capabilities = capabilities }
          vim.lsp.config.perlpls.setup { capabilities = capabilities }
          vim.lsp.config.pyright.setup { capabilities = capabilities }
          vim.lsp.config.solargraph.setup { capabilities = capabilities }
          vim.lsp.config.terraformls.setup { capabilities = capabilities }
          vim.lsp.config.ts_ls.setup { capabilities = capabilities }

          vim.lsp.config.yamlls.setup {
            capabilities = capabilities,
            settings = {
              yaml = {
                format = {
                  enable = true,
                },
                keyOrdering = false,
              },
              redhat = {
                telemetry = {
                  enabled = false
                }
              },
            },
          }

          vim.lsp.config.zls.setup { capabilities = capabilities }


          vim.keymap.set('n', '<Leader>fmt', function() vim.lsp.buf.format { async = true } end, { noremap = true, silent = true })
          vim.keymap.set('n', 'gd', function() vim.lsp.buf.definition() end, { noremap = true, silent = true })
          vim.keymap.set('n', 'gD', function() vim.lsp.buf.declaration() end, { noremap = true, silent = true })
          vim.keymap.set('n', 'K', function() vim.lsp.buf.hover() end, { noremap = true, silent = true })
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
