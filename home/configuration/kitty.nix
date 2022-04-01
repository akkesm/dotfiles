{ config, pkgs, ... }:

{
  home = {
    packages = [ pkgs.ffmpeg-full ]; # For icat kitten
    sessionVariables.TERMINAL = "${pkgs.kitty}/bin/kitty";
  };

  programs = {
    kitty = {
      enable = true;

      extraConfig =
      let
        kitty-nord-conf = pkgs.fetchurl {
          url = "https://raw.githubusercontent.com/connorholyday/nord-kitty/master/nord.conf";
          sha256 = "1fbnc6r9mbqb6wxqqi9z8hjhfir44rqd6ynvbc49kn6gd8v707p1";
        };
      in
      ''
        include ${kitty-nord-conf}
      '';

      font = {
        name = config.fonts.monospace;
        size = 12;
      };

      keybindings = {
        "ctrl+shift+c" = "copy_and_clear_or_interrupt";
        "ctrl+tab" = "next_window";
        "ctrl+shift+tab" = "previous_window";
        "ctrl+shift+8" = "launch --cwd=current --location=vsplit";
        "ctrl+shift+9" = "launch --cwd=current --location=hsplit";
        "alt+shift+h" = "move_window left";
        "alt+shift+j" = "move_window down";
        "alt+shift+k" = "move_window up";
        "alt+shift+l" = "move_window right";
        "alt+1" = "goto_tab 1";
        "alt+2" = "goto_tab 2";
        "alt+3" = "goto_tab 3";
        "alt+4" = "goto_tab 4";
        "alt+5" = "goto_tab 5";
        "alt+6" = "goto_tab 6";
        "alt+7" = "goto_tab 7";
        "alt+8" = "goto_tab 8";
        "alt+9" = "goto_tab 9";

        # vim-kitty-navigator config
        # "alt+h" = "kitten pass_keys.py neighboring_window bottom alt+h '^.* - nvim$'";
        # "alt+j" = "kitten pass_keys.py neighboring_window bottom alt+j '^.* - nvim$'";
        # "alt+k" = "kitten pass_keys.py neighboring_window bottom alt+k '^.* - nvim$'";
        # "alt+l" = "kitten pass_keys.py neighboring_window bottom alt+l '^.* - nvim$'";
      };

      settings = {
        active_border_color = "#a3be8c";
        inactive_border_color = "#5e81ac";

        disable_ligatures = "cursor";
        touch_scroll_multiplier = "1.5";
        open_url_with = "firefox";
        strip_trailing_spaces = "smart";
        focus_follows_mouse = false;
        enable_audio_bell = false;
        remember_window_size = true;
        enabled_layouts = "splits:split_axis=horizontal";
        tab_bar_style = "powerline";
        tab_separator = " ┇ ";
        tab_powerline_style = "angled";
        close_on_child_death = "yes";
        update_check_interval = 0;

        # vim-kitty-navigator config
        # allow_remote_control = true;
        # listen_on = "unix:@mykitty";
      };
    };

    zsh.shellGlobalAliases = { ssh = "kitty +kitten ssh"; };
  };
  # services.xdg = {
    # configFile = 
    #   let
    #     kitty-neighboring_window-py = builtins.fetchurl "https://raw.githubusercontent.com/knubie/vim-kitty-navigator/master/neighboring_window.py";
    #     kitty-pass_keys-py = builtins.fetchurl "https://raw.githubusercontent.com/knubie/vim-kitty-navigator/master/pass_keys.py";
    #   in
    #   {
    #     "user-dirs.locale".text = "it_IT";
    #     "kitty/neighboring_window.py".source = kitty-neighboring_window-py;
    #     "kitty/pass_keys.py".source = kitty-pass_keys-py;
    #   };
  # };
}
