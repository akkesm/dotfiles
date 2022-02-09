{ config, pkgs, ... }:

{
  programs.neovim.plugins = with pkgs.vimPlugins; [
    {
      plugin = lualine-nvim;
      type = "lua";
      config = ''
        require('lualine').setup {
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
                        , { 'diagnostics', sources = { 'nvim_diagnostic' } }
                        , { 'lsp_progress' } },
            lualine_x = { 'encoding', 'fileformat', 'filetype' },
            lualine_y = { 'progress' },
            lualine_z = { 'location' },
          },
          inactive_sections = {
            lualine_a = {},
            lualine_b = {},
            lualine_c = { 'filename' },
            lualine_x = { 'location' },
            lualine_y = {},
            lualine_z = {},
          },
          extensions = {
            'fzf',
            'nvim-tree',
          },
        }
      '';
    }

    lualine-lsp-progress
  ];
}
