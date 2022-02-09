{ config, pkgs, ... }:

{
  programs.neovim = {
    extraPackages = [ pkgs.vimb ];

    plugins = [
      {
        plugin = pkgs.vimPlugins.vim-markdown-composer;
        type = "lua";
        config = ''
          vim.g.markdown_composer_autostart = 0
          vim.g.markdown_composer_browser = 'vimb'
          vim.g.markdown_composer_refresh_rate = 1000
          vim.g.markdown_composer_syntax_theme = 'nord'
        '';
      }
    ];
  };
}
