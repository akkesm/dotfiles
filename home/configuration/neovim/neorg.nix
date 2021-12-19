{ config, pkgs, ... }:

{
  programs.neovim.plugins = with pkgs.vimPlugins; [
    {
      plugin = neorg;
      config = ''
        lua << EOF
        require('neorg').setup({
          load = {
            ['core.defaults'] = { },
            ['core.highlights'] = { },
            ['core.integrations.telescope'] = { },
            ['core.integrations.treesitter'] = { },
            ['core.keybinds'] = {
              config = {
                default_keybinds = true
              }
            },
            ['core.norg.concealer'] = { },
            ['core.norg.dirman'] = {
              config = {
                autodetect = true,
                autochdir = true,

                workspaces = {
                  uni = "${config.xdg.userDirs.documents}/UNI/notes"
                }
              }
            }
          },
          logger = {
            use_file = true;
          }
        })
        EOF
      '';
    }

    neorg-telescope
  ];
}
