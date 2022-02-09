{ config, pkgs, ... }:

{
  programs.neovim.plugins = with pkgs.vimPlugins; [
    {
      plugin = neorg;
      type = "lua";
      config = ''
        require('neorg').setup {
          load = {
            core = {
              defaults = {},
              highlights = {},
  
              integrations = {
                telescope = {},
                treesitter = {},
              },

              ['keybinds.config.default_keybinds'] = true,
  
              norg = {
                concealer = {},
  
                ['dirman.config'] = {
                  autodetect = true,
                  autochdir = true,
                  ['workspaces.uni'] = "${config.xdg.userDirs.documents}/UNI/notes",
                },
              },
            },
          },
  
          ['logger.use_file'] = true,
        }
      '';
    }

    neorg-telescope
  ];
}
