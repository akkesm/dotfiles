{ pkgs, ... }:

{
  programs.neovim = {
    extraPackages = with pkgs; [
      rust-analyzer
      graphviz
    ];

    plugins = with pkgs.vimPlugins; [
      {
        plugin = rust-tools-nvim;
        type = "lua";
        config = ''
          require('rust-tools').setup {}
        '';
      }

      nvim-dap
    ];
  };
}
