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

            ['core.norg.concealer'] = { config = { folds = false } },
            ['core.norg.esupports.metagen'] = { config = { type = 'empty' } },
            ['core.export'] = {},
            ['core.export.markdown'] = { config = { extensions = 'all' } },
            ['core.integrations.treesitter'] = {},

            ['core.norg.dirman'] = {
              config = {
                autodetect = true,
                autochdir = true,
                ['workspaces.uni'] = "${config.xdg.userDirs.documents}/UNI/notes",
              },
            },

            -- External modules
            ['core.integrations.telescope'] = {},
          },

          ['logger.use_file'] = true,
        }
      '';
    }

    neorg-telescope
  ];
}
