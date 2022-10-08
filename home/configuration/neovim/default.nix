{ config, lib, pkgs, ... }:

{
  imports = [
    ./coq.nix
    ./latex.nix
    ./mini.nix
    ./neorg.nix
    ./telescope.nix
    ./treesitter.nix
    ./vim-markdown-composer.nix
  ];

  home.sessionVariables.EDITOR = "nvim";

  programs.neovim = {
    enable = true;

    extraConfig = ''
      luafile ${./init.lua}
      luafile ${pkgs.writeText "generatedConfig.lua" config.programs.neovim.generatedConfigs.lua}
      lua vim.opt.backupdir = "${config.xdg.stateHome}/nvim/backup//"
    '';

    extraPackages = [ pkgs.lf ];

    plugins = with pkgs.vimPlugins; [
      # Used by multiple other plugins
      nvim-web-devicons
      plenary-nvim

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

      {
        plugin = nvim-cursorline;
        type = "lua";
        config = ''
          require('nvim-cursorline').setup()
        '';
      }

      {
        plugin = dirbuf-nvim;
        type = "lua";
        config = ''
          require('dirbuf').setup {
            sort_order = 'directories_first'
          }
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
          require('registers').setup {
            symbols = {
              tab = "»·"
            }
          }
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
          vim.g.mundo_width = 100
          vim.keymap.set('n', '<Leader>u', '<Cmd>MundoToggle<CR>', { noremap = true })
        '';
      }
    ];

    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    withNodeJs = true;
    withPython3 = true;
    withRuby = true;
  };
}

