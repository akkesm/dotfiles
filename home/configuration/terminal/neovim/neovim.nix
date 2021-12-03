{ config, lib, pkgs, ... }:

{
  home.activation."extraDirs" = lib.hm.dag.entryAfter [ "writeboundary" ] ''
    $DRY_RUN_CMD mkdir $VERBOSE_ARG -p ${config.xdg.dataHome}/nvim/backup
    $DRY_RUN_CMD mkdir $VERBOSE_ARG -p ${config.xdg.dataHome}/nvim/workbench
  '';

  programs.neovim = {
    enable = true;
    extraConfig = builtins.readFile ./init.vim;

    extraPackages = with pkgs; [

      # LSP servers
      ccls
      clojure-lsp
      gopls
      haskellPackages.haskell-language-server
      luajitPackages.lua-lsp
      nodePackages.bash-language-server
      # nodePackages.diagnostic-languageserver
      nodePackages.dockerfile-language-server-nodejs
      nodePackages.pyright
      nodePackages.typescript-language-server
      nodePackages.vim-language-server
      nodePackages.vscode-html-languageserver-bin
      nodePackages.vscode-json-languageserver-bin
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

      # For coq_nvim
      sqlite

      # For vim-markdown-composer
      vimb
    ];

    package = pkgs.neovim-master;

    plugins = with pkgs.vimPlugins; [
      # themes
      # {
      #   plugin = nvim-base16;
      #   config = ''
      #     lua require('base16-colorscheme').setup('nord')
      #   '';
      # }
      {
        plugin = nord-nvim;
        config = ''
          lua << EOF
          vim.g.nord_contrast = false
          vim.g.nord_borders = true
          vim.g.nord_cursorline_transparent = false
          require('nord').set()
          EOF
        '';
      }
      {
        plugin = indent-blankline-nvim;
        config = ''
          lua << EOF
          require('indent_blankline').setup({
            char = '›',
            space_char = '·',
            space_char_blankline = ' ',
            show_current_context = true,
            show_end_of_line = false,
            show_trailing_blankline_indent = false,
            use_treesitter = true
          })
          EOF
        '';
      }
      nvim-cursorline

      # status line
      {
        plugin = lualine-nvim;
        config = ''
          lua << EOF
          require('lualine').setup({
            options = {
              theme = 'nord',
              section_separators = { '', '' },
              component_separators = { '', '' },
              icons_enabled = 1,
            },
            sections = {
              lualine_a = { { 'mode', upper = true } },
              lualine_b = { { 'branch', icon = '' } },
              lualine_c = { { 'filename', file_status = true, path = 1 }
                          , { 'diagnostics', sources = { 'nvim_lsp' } }
                          , { 'lsp_progress' } },
              lualine_x = { 'encoding', 'fileformat', 'filetype' },
              lualine_y = { 'progress' },
              lualine_z = { 'location' },
            },
            inactive_sections = {
              lualine_a = { },
              lualine_b = { },
              lualine_c = { 'filename' },
              lualine_x = { 'location' },
              lualine_y = { },
              lualine_z = { }
            },
            extensions = {
              'fzf',
              'nvim-tree'
            }
          })
          EOF
        '';
      }
      lualine-lsp-progress

      # LSP
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

      {
        plugin = nvim-lspconfig;
        config = ''
          lua << EOF
          local lspconfig = require('lspconfig')
          local coq = require('coq')
          lspconfig.bashls.setup(coq.lsp_ensure_capabilities({}))
          lspconfig.ccls.setup(coq.lsp_ensure_capabilities({
            root_dir = root_pattern('compile_commands.json', '.ccls', 'compile_flags.txt', '.git', 'flake.nix') or dirname
          }))
          lspconfig.clojure_lsp.setup(coq.lsp_ensure_capabilities({
            root_dir = root_pattern('project.clj', 'deps.edn', 'build.boot', 'shadow-cljs.edn', '.git', 'flake.nix') or lspconfig.util.path.dirname
          }))
          -- lspconfig.diagnosticls.setup(coq.lsp_ensure_capabilities({}))
          lspconfig.dockerls.setup(coq.lsp_ensure_capabilities({
                root_dir = root_pattern('Dockerfile', '.git', 'flake.nix') or lspconfig.util.path.dirname
          }))
          lspconfig.gopls.setup(coq.lsp_ensure_capabilities({
            root_dir = root_pattern('go.mod', '.git', 'flake.nix') or lspconfig.util.path.dirname
          }))
          lspconfig.hls.setup(coq.lsp_ensure_capabilities({
            root_dir = root_pattern('*.cabal', 'stack.yaml', 'cabal.project', 'package.yaml', 'hie.yaml', '.git', 'flake.nix') or lspconfig.util.path.dirname
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
          lspconfig.pyright.setup(coq.lsp_ensure_capabilities({}))
          lspconfig.rnix.setup(coq.lsp_ensure_capabilities({}))
          lspconfig.scry.setup(coq.lsp_ensure_capabilities({
            root_dir = root_pattern('shard.yml', '.git', 'flake.nix') or lspconfig.util.path.dirname
          }))
          lspconfig.solargraph.setup(coq.lsp_ensure_capabilities({
            root_dir = lspconfig.util.root_pattern('Gemfile', '.git', 'flake.nix') or lspconfig.util.path.dirname
          }))
          lspconfig.sqls.setup(coq.lsp_ensure_capabilities({})

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
                    [vim.fn.expand('$VIMRUNTIME/lua')] = true,
                    [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true
                  }
                },
                telemetry = {
                  enable = false
                }
              }
            }
          }))

          lspconfig.terraformls.setup(coq.lsp_ensure_capabilities({
            root_dir = root_pattern(".terraform", ".git", 'flake.nix') or lspconfig.util.path.dirname
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

          lspconfig.tsserver.setup(coq.lsp_ensure_capabilities({}))
          lspconfig.vimls.setup(coq.lsp_ensure_capabilities({}))
          lspconfig.yamlls.setup(coq.lsp_ensure_capabilities({}))
          lspconfig.zls.setup(coq.lsp_ensure_capabilities({
            root_dir = root_pattern("zls.json", ".git", 'flake.nix') or lspconfig.util.path.dirname
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
      vim-vsnip
      vim-vsnip-integ
      trouble-nvim

      # hlslens
      {
        plugin = nvim-hlslens;
        config = ''
          noremap <silent> n <Cmd>execute('normal! ' . v:count1 . 'n')<CR> <Cmd>lua require('hlslens').start()<CR>
          noremap <silent> N <Cmd>execute('normal! ' . v:count1 . 'N')<CR> <Cmd>lua require('hlslens').start()<CR>
          map * <Plug>(asterisk-*)<Cmd>lua require('hlslens').start()<CR>
          map # <Plug>(asterisk-#)<Cmd>lua require('hlslens').start()<CR>
          map g* <Plug>(asterisk-g*)<Cmd>lua require('hlslens').start()<CR>
          map g# <Plug>(asterisk-g#)<Cmd>lua require('hlslens').start()<CR>
          map z* <Plug>(asterisk-z*)<Cmd>lua require('hlslens').start()<CR>
          map z# <Plug>(asterisk-z#)<Cmd>lua require('hlslens').start()<CR>
          map gz* <Plug>(asterisk-gz*)<Cmd>lua require('hlslens').start()<CR>
          map gz# <Plug>(asterisk-gz#)<Cmd>lua require('hlslens').start()<CR>
        '';
      }
      vim-asterisk

      # file explorer
      {
        plugin = chadtree;
        config = ''
          let g:chadtree_settings = {
          \ 'xdg': v:true,
          \ 'ignore.name_exact': [],
          \ 'view': {
          \   'sort_by': [ 'is_folder', 'file_name', 'ext' ],
          \   'width': 30
          \ },
          \ 'theme.text_colour_set' : 'nord'
          \}

          nnoremap <Leader>t <Cmd>CHADopen<CR>

          " Start CHADTree when Vim starts with a directory argument
          autocmd StdinReadPre * let s:std_in=1
          autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists('s:std_in') |
          \ execute 'CHADopen' argv()[0] | wincmd p | enew | execute 'cd '.argv()[0] | endif
        '';
      }

      # lf integration
      {
        plugin = lf-vim;
        config = ''
          lua vim.g.lf_map_keys = 0
          map <Leader>lf <Cmd>Lf<CR>
        '';
      }

      {
        plugin = registers-nvim;
        config = ''
          lua vim.g.registers_tab_symbol = '»·'
        '';
      }

      # telescope
      {
        plugin = telescope-nvim;
        config = ''
          nnoremap <Leader>ff <Cmd>lua require('telescope.builtin').find_files()<CR>
          nnoremap <Leader>fg <Cmd>lua require('telescope.builtin').live_grep()<CR>
          nnoremap <Leader>fb <Cmd>lua require('telescope.builtin').buffers()<CR>
          nnoremap <Leader>fh <Cmd>lua require('telescope.builtin').help_tags()<CR>
        '';
      }
      plenary-nvim
      popup-nvim
      telescope-fzf-writer-nvim
      telescope-symbols-nvim

      # treesitter
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
        plugin = nvim-autopairs;
        config = ''
          lua << EOF
          _G.MUtils= {}

          vim.g.completion_confirm_key = ""

          MUtils.completion_confirm=function()
            if vim.fn.pumvisible() ~= 0  then
              if vim.fn.complete_info()["selected"] ~= -1 then
                return vim.fn['compe#confirm'](require('nvim-autopairs').esc('<CR>'))
              else
                return require('nvim-autopairs').esc("<CR>")
              end
            else
              return require('nvim-autopairs').autopairs_cr()
            end
          end

          vim.api.nvim_set_keymap('i' , '<CR>', 'v:lua.MUtils.completion_confirm()', { expr = true , noremap = true })

          require('nvim-autopairs').setup({
            check_ts = true,
            ignored_next_char = string.gsub([[ [%w%%%?%'%[%"%.] ]], '%s+', "")
          })
          require('nvim-treesitter.configs').setup({
            autopairs = {
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

      nvim-web-devicons

      {
        plugin = nvim-workbench;
        config = ''
          nnoremap <Leader>wb <Plug>ToggleBranchWorkbench
          nnoremap <Leader>wp <Plug>ToggleProjectWorkbench
          lua vim.g.workbench_border = 'single'
          lua vim.g.workbench_storage_path = "${config.xdg.dataHome}/nvim/workbench"
        '';
      }

      {
        plugin = vim-kitty-navigator;
        config = ''
          set title
          set titlestring=%<%F%=%l/%L-%P\ -\ nvim
          lua vim.g.kitty_navigator_no_mappings = 1
          nnoremap <silent> <A-h> :KittyNavigateLeft<CR>
          nnoremap <silent> <A-j> :KittyNavigateDown<CR>
          nnoremap <silent> <A-k> :KittyNavigateUp<CR>
          nnoremap <silent> <A-l> :KittyNavigateRight<CR>
        '';
      }

      # LaTeX
      vimtex
      {
        plugin = vim-latex-live-preview;
        config = ''
          lua << EOF
          vim.g.livepreview_cursorhold_recompile = 0
          vim.g.livepreview_engine = 'xelatex'
          vim.g.livepreview_previewer = 'zathura'
          vim.g.livepreview_use_biber = 1
          EOF
        '';
      }

      # mappings
      {
        plugin = which-key-nvim;
        config = ''
          lua require('which-key').setup({})
        '';
      }

      # notes
      {
        plugin = due_nvim;
        config = ''
          lua << EOF
          require('due_nvim').setup({
            ft = '{*.md,*.org,*.norg}'
          })
          EOF
        '';
      }
      {
        plugin = vim-markdown-composer;
        config = ''
          lua << EOF
          vim.g.markdown_composer_autostart = 0
          vim.g.markdown_composer_browser = 'vimb'
          vim.g.markdown_composer_refresh_rate = 1000
          vim.g.markdown_composer_syntax_theme = 'nord'
          EOF
        '';
      }

      {
        plugin = vim-mundo;
        config = ''
          lua vim.g.mundo_width = 50

          nnoremap <Leader>u <Cmd>MundoToggle<CR>
        '';
      }

      {
        plugin = nabla-nvim;
        config = ''
          nnoremap <Leader>ln <Cmd>lua require('nabla').action()<CR>
        '';
      }

      neorg-telescope
      {
        plugin = neorg;
        config = ''
          lua << EOF
          require('neorg').setup({
            load = {
              ['core.defaults'] = { },
              ['core.highlights'] = { },
              ['core.integrations.telescope'] = { },
              ['core.integrations.treesitter'] = { },
              ['core.keybinds'] = {
                config = {
                  default_keybinds = true
                }
              },
              ['core.norg.concealer'] = { },
              ['core.norg.dirman'] = {
                config = {
                  autodetect = true,
                  autochdir = true,

                  workspaces = {
                    uni = "${config.xdg.userDirs.documents}/UNI/notes"
                  }
                }
              }
            },
            logger = {
              use_file = true;
            }
          })
          EOF
        '';
      }
    ];

    vimAlias = true;
    vimdiffAlias = true;
    withNodeJs = true;
    withPython3 = true;
    withRuby = true;
  };
}
