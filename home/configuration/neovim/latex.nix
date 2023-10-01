{ pkgs, ... }:

{
  programs.neovim = {
    extraPackages = with pkgs; [
      biber
      neovim-remote
      zathura
      xdotool
    ];

    plugins = with pkgs.vimPlugins; [
      {
        plugin = vimtex;
        type = "lua";
        config = ''
          vim.g.vimtex_compiler_progname = 'nvr'
          vim.g.vimtex_view_method = 'zathura'
        '';
      }
      {
        plugin = vim-latex-live-preview;
        type = "lua";
        config = ''
          vim.g.livepreview_cursorhold_recompile = 0
          vim.g.livepreview_engine = 'xelatex'
          vim.g.livepreview_previewer = 'zathura'
          vim.g.livepreview_use_biber = 1
        '';
      }
    ];
  };
}
