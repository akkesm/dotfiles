{ pkgs, ... }:

{
  programs.neovim.plugins = with pkgs.vimPlugins; [
    {
      plugin = lualine-nvim;
      type = "lua";
      config = ''
        require('lualine').setup {
          options = {
            component_separators = { left = '', right = ''},
            section_separators = { left = '', right = ''},
            globalstatus = true,
          },
          sections = {
            lualine_a = { { 'mode', upper = true } },
            lualine_b = { { 'branch', icon = '' } },
            lualine_c = {
              { 'filename', file_status = true, path = 1 },
              { 'diagnostics', sources = { 'nvim_diagnostic' } },
              { 'lsp_progress' }
            },
            lualine_x = { 'encoding', 'fileformat', 'filetype' },
            lualine_y = { 'progress' },
            lualine_z = { 'location' },
          },
          inactive_sections = {
            lualine_a = {},
            lualine_b = { { 'branch', icon = '' } },
            lualine_c = { 'filename' },
            lualine_x = { 'location' },
            lualine_y = {},
            lualine_z = {},
          },
        }
      '';
    }

    lualine-lsp-progress

    # {
    #   plugin = windline-nvim;
    #   type = "lua";
    #   config = ''
    #     require('windline').setup {
    #       statuslines = {
    #         default = {
    #           filetypes = { 'default' },
    #           active={
    #           },
    #           inactive={
    #           }
    #         },
    #       }
    #     }
    #   '';
    # }
  ];
}
