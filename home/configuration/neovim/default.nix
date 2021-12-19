{ config, lib, pkgs, ... }:

{
  imports = [
    ./lsp.nix
    ./lualine.nix
    ./neorg.nix
    ./treesitter.nix
  ];

  home = {
    activation."extraDirs" = lib.hm.dag.entryAfter [ "writeboundary" ] ''
      $DRY_RUN_CMD mkdir $VERBOSE_ARG -p ${config.xdg.dataHome}/nvim/backup
      $DRY_RUN_CMD mkdir $VERBOSE_ARG -p ${config.xdg.dataHome}/nvim/workbench
    '';

    sessionVariables = { EDITOR = "nvim"; };
  };

  programs.neovim = {
    enable = true;
    # extraConfig = builtins.readFile ./init.vim;
    extraConfig = ''
      luafile ${./init.lua}
      lua vim.opt.backupdir = "${config.xdg.dataHome}/nvim/backup"
    '';

    extraPackages = with pkgs; [
      perlPackages.NeovimExt

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
            char = '⟩',
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
    ];

    vimAlias = true;
    vimdiffAlias = true;
    withNodeJs = true;
    withPython3 = true;
    withRuby = true;
  };
}
