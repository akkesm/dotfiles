{ config, pkgs, ... }:

{
  programs.neovim = {
    extraLuaPackages = (ps: with ps; [
      lua-utils-nvim
      nvim-nio
      pathlib-nvim
    ]);

    plugins = with pkgs.vimPlugins; [
      {
        plugin = neorg;
        type = "lua";
        config = ''
          require('neorg').setup {
            load = {
              ['core.defaults'] = {},

              ['core.concealer'] = { config = { folds = false } },
              ['core.esupports.metagen'] = { config = { type = 'empty' } },
              ['core.export'] = {},
              ['core.export.markdown'] = { config = { extensions = 'all' } },
              ['core.integrations.treesitter'] = {},

              ['core.dirman'] = {
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
  };
}
