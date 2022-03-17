{ config, lib, pkgs, ... }:

{
  imports = [
    ./coq.nix
    ./lualine.nix
    ./neorg.nix
    ./telescope.nix
    ./treesitter.nix
    ./vim-markdown-composer.nix
  ];

  home = {
    activation."extraDirs" = lib.hm.dag.entryAfter [ "writeboundary" ] ''
      $DRY_RUN_CMD mkdir $VERBOSE_ARG -p ${config.xdg.dataHome}/nvim/backup
      $DRY_RUN_CMD mkdir $VERBOSE_ARG -p ${config.xdg.dataHome}/nvim/workbench
    '';

    sessionVariables.EDITOR = "nvim";
  };

  programs.neovim = {
    enable = true;
    extraConfig = ''
      luafile ${./init.lua}
      luafile ${pkgs.writeText "generatedConfig.lua" config.programs.neovim.generatedConfigs.lua}
      lua vim.opt.backupdir = "${config.xdg.dataHome}/nvim/backup"
    '';

    extraPackages = with pkgs; [
      lf
      perlPackages.NeovimExt
    ];

    package = pkgs.neovim-master;

    plugins = with pkgs.vimPlugins; [
      # Used by multiple other plugins
      plenary-nvim

      # theme
      # {
      #   plugin = nvim-base16;
      #   config = ''
      #     colorscheme base16-nord
      #   '';
      # }
      {
        plugin = nord-nvim;
        type = "lua";
        config = ''
          vim.g.nord_borders = true
          vim.g.nord_italic = false
          require('nord').set()
        '';
      }
      {
        plugin = indent-blankline-nvim;
        type = "lua";
        config = ''
          require('indent_blankline').setup {
            -- char = '⟩',
            space_char = '·',
            space_char_blankline = ' ',
            show_current_context = true,
            show_end_of_line = false,
            show_trailing_blankline_indent = false,
            use_treesitter = true,
          }
        '';
      }
      nvim-cursorline

      dirbuf-nvim

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
        type = "lua";
        config = ''
          vim.g.lf_map_keys = 0
          vim.keymap.set("", '<Leader>lf', '<Cmd>Lf<CR>', { noremap = true, silent = true })
        '';
      }

      {
        plugin = registers-nvim;
        type = "lua";
        config = ''
          vim.g.registers_tab_symbol = '»·'
        '';
      }

      nvim-web-devicons

      {
        plugin = nvim-workbench;
        type = "lua";
        config = ''
          vim.keymap.set('n', '<Leader>wb', '<Plug>ToggleBranchWorkbench', { noremap = true })
          vim.keymap.set('n', '<Leader>wp', '<Plug>ToggleProjectWorkbench', { noremap = true })
          vim.g.workbench_border = 'single'
          vim.g.workbench_storage_path = "${config.xdg.dataHome}/nvim/workbench"
        '';
      }

      {
        plugin = vim-kitty-navigator;
        type = "lua";
        config = ''
          vim.opt.title = true
          vim.opt.titlestring = '%<%F%=%l/%L-%P - nvim'
          vim.g.kitty_navigator_no_mappings = 1
          vim.keymap.set('n', '<silent> <A-h>', ':KittyNavigateLeft<CR>', { noremap = true })
          vim.keymap.set('n', '<silent> <A-j>', ':KittyNavigateDown<CR>', { noremap = true })
          vim.keymap.set('n', '<silent> <A-k>', ':KittyNavigateUp<CR>', { noremap = true })
          vim.keymap.set('n', '<silent> <A-l>', ':KittyNavigateRight<CR>', { noremap = true })
        '';
      }

      # LaTeX
      vimtex
      {
        plugin = vim-latex-live-preview;
        type = "lua";
        config = ''
          vim.g.livepreview_cursorhold_recompile = 0
          vim.g.livepreview_engine = 'xelatex'
          vim.g.livepreview_previewer = 'zathura'
          vim.g.livepreview_use_biber = 1
        '';
      }

      # mappings
      {
        plugin = which-key-nvim;
        type = "lua";
        config = ''
          require('which-key').setup { ['window.border'] = 'single' }
        '';
      }

      # notes
      {
        plugin = due_nvim;
        type = "lua";
        config = ''
          require('due_nvim').setup {
            ft = '*.md,*.org,*.norg',
            use_clock_time = true,
          }
        '';
      }

      {
        plugin = vim-mundo;
        type = "lua";
        config = ''
          vim.g.mundo_width = 50

          vim.keymap.set('n', '<Leader>u', '<Cmd>MundoToggle<CR>', { noremap = true })
        '';
      }

      {
        plugin = nabla-nvim;
        type = "lua";
        config = ''
          vim.keymap.set('n', '<Leader>ln', function() return require('nabla').action() end, { noremap = true })
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
