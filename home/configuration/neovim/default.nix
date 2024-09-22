{ config, pkgs, ... }:

{
  imports = [
    # ./coq.nix
    ./lsp
    ./latex.nix
    ./mini.nix
    ./neorg.nix
    ./nnn.nix
    ./nvim-autopairs.nix
    ./nvim-surround.nix
    ./telescope.nix
    ./treesitter.nix
    # ./vim-markdown-composer.nix
  ];

  home.sessionVariables.EDITOR = "nvim";

  programs.neovim = {
    enable = true;

    extraConfig = ''
      luafile ${./init.lua}
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
          require('ibl').setup()
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

      markview-nvim
    ];

    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    withNodeJs = true;
    withPython3 = true;
    withRuby = true;
  };
}

