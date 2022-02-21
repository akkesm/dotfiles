{ config, pkgs, ... }:

{
  programs.neovim.plugins = with pkgs.vimPlugins; [
    {
      plugin = neorg;
      type = "lua";
      config = ''
        require('neorg').setup {
          load = {
            ['core.defaults'] = {},
            ['core.norg.esupports.metagen'] = { config = { type = 'auto' } },
            ['core.integrations.telescope'] = {},
            ['core.integrations.treesitter'] = {},
            ['core.norg.concealer'] = {},

            ['core.norg.dirman'] = {
              config = {
                autodetect = true,
                autochdir = true,
                ['workspaces.uni'] = "${config.xdg.userDirs.documents}/UNI/notes",
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
