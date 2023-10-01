{ pkgs, ... }:

{
  programs.neovim.plugins = with pkgs.vimPlugins; [
    {
      plugin = nvim-autopairs;
      type = "lua";
      config = ''
        require('nvim-autopairs').setup {
          enable_check_bracket_line = false,
          fast_wrap = {},
          ignored_next_char = "[%w%.]"
        }

        require('cmp').event:on(
          'confirm_done',
          require('nvim-autopairs.completion.cmp').on_confirm_done()
        )
      '';
    }

    {
      plugin = nvim-ts-autotag;
      type = "lua";
      config = ''
        require('nvim-ts-autotag').setup()
      '';
    }
  ];
}
