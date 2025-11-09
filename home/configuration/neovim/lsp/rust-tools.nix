{ pkgs, ... }:

{
  programs.neovim = {
    extraPackages = with pkgs; [
      rust-analyzer
      graphviz
    ];

    plugins = with pkgs.vimPlugins; [
      rustaceanvim
      nvim-dap
      nvim-dap-lldb
    ];
  };
}
