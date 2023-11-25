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
      pyright
      typescript-language-server typescript
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
          local lspconfig = require 'lspconfig'
          local capabilities = require('cmp_nvim_lsp').default_capabilities()

          lspconfig.bashls.setup { capabilities = capabilities }
          lspconfig.ccls.setup {
            capabilities = capabilities,
            root_dir = lspconfig.util.root_pattern('compile_commands.json', '.ccls', '.git', 'Makefile'),
            single_file_support = true,
          }

          lspconfig.cssls.setup { capabilities = capabilities }

          lspconfig.docker_compose_language_service.setup { capabilities = capabilities }
          lspconfig.dockerls.setup { capabilities = capabilities }

          lspconfig.elixirls.setup {
            capabilities = capabilities,
            cmd = { '${pkgs.elixir-ls}/bin/elixir-ls' },
          }

          lspconfig.gopls.setup { capabilities = capabilities }

          lspconfig.hls.setup {
              capabilities = capabilities,
              cmd = { '${hls-cmd}', '--lsp' },
              setting = { haskell = { formattingProvider = "fourmolu" } }
          }

          lspconfig.html.setup {
            capabilities = capabilities,
            cmd = { '${pkgs.nodePackages.vscode-html-languageserver-bin}/bin/html-languageserver', '--stdio' },
          }

          lspconfig.jdtls.setup { capabilities = capabilities }

          lspconfig.jsonls.setup {
            capabilities = capabilities,
            cmd = { '${pkgs.nodePackages.vscode-json-languageserver-bin}/bin/json-languageserver', '--stdio' }
          }

          lspconfig.lua_ls.setup {
            capabilities = capabilities,
            on_init = function(client)
              local path = client.workspace_folders[1].name
              if not vim.loop.fs_stat(path..'/.luarc.json') and not vim.loop.fs_stat(path..'/.luarc.jsonc') then
                client.config.settings = vim.tbl_deep_extend('force', client.config.settings.Lua, {
                  runtime = { version = 'LuaJIT' },
                  workspace = { library = { vim.env.VIMRUNTIME } }
                })

                client.notify('workspace/didChangeConfiguration', { settings = client.config.settings })
              end
              return true
            end
          }

          lspconfig.marksman.setup { capabilities = capabilities }

          lspconfig.nil_ls.setup {
              capabilities = capabilities,
              settings = { ['nil'] = { formatting = { command = { 'nixpkgs-fmt' } } } }
          }

          lspconfig.nimls.setup { capabilities = capabilities }
          lspconfig.perlpls.setup { capabilities = capabilities }
          lspconfig.pyright.setup { capabilities = capabilities }
          lspconfig.solargraph.setup { capabilities = capabilities }
          lspconfig.terraformls.setup { capabilities = capabilities }
          lspconfig.tsserver.setup { capabilities = capabilities }
          lspconfig.yamlls.setup { capabilities = capabilities }
          lspconfig.zls.setup { capabilities = capabilities }


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
