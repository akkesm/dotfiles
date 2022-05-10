{ pkgs, ... }:

{
  programs.neovim = {
    extraPackages = [ pkgs.neovim-remote ];

    plugins = with pkgs.vimPlugins; [
      {
        plugin = vimtex;
        type = "lua";
        config = ''
          vim.g.vimtex_compiler_progname = 'nvr'
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
