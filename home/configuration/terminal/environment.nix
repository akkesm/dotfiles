{ config, lib, pkgs, ... }:

{
  programs = {
    dircolors = {
      enable = true;
      enableFishIntegration = false;

      settings = {
        # https://github.com/arcticicestudio/nord-dircolors/blob/develop/src/dir_colors
        #+-----------------+
        #+ Global Defaults +
        #+-----------------+
        "NORMAL" = "00";
        "RESET" = "0";

        "FILE" = "00";
        "DIR" = "01;34";
        "LINK" = "36";
        "MULTIHARDLINK" = "04;36";

        "FIFO" = "04;01;36";
        "SOCK" = "04;33";
        "DOOR" = "04;01;36";
        "BLK" = "01;33";
        "CHR" = "33";

        "ORPHAN" = "31";
        "MISSING" = "01;37;41";

        "EXEC" = "01;36";

        "SETUID" = "01;04;37";
        "SETGID" = "01;04;37";
        "CAPABILITY" = "01;37";

        "STICKY_OTHER_WRITABLE" = "01;37;44";
        "OTHER_WRITABLE" = "01;04;34";
        "STICKY" = "04;37;44";

        #+-------------------+
        #+ Extension Pattern +
        #+-------------------+
        #+--- Archives ---+
        ".7z" = "01;32";
        ".ace" = "01;32";
        ".alz" = "01;32";
        ".arc" = "01;32";
        ".arj" = "01;32";
        ".bz" = "01;32";
        ".bz2" = "01;32";
        ".cab" = "01;32";
        ".cpio" = "01;32";
        ".deb" = "01;32";
        ".dz" = "01;32";
        ".ear" = "01;32";
        ".gz" = "01;32";
        ".jar" = "01;32";
        ".lha" = "01;32";
        ".lrz" = "01;32";
        ".lz" = "01;32";
        ".lz4" = "01;32";
        ".lzh" = "01;32";
        ".lzma" = "01;32";
        ".lzo" = "01;32";
        ".rar" = "01;32";
        ".rpm" = "01;32";
        ".rz" = "01;32";
        ".sar" = "01;32";
        ".t7z" = "01;32";
        ".tar" = "01;32";
        ".taz" = "01;32";
        ".tbz" = "01;32";
        ".tbz2" = "01;32";
        ".tgz" = "01;32";
        ".tlz" = "01;32";
        ".txz" = "01;32";
        ".tz" = "01;32";
        ".tzo" = "01;32";
        ".tzst" = "01;32";
        ".war" = "01;32";
        ".xz" = "01;32";
        ".z" = "01;32";
        ".Z" = "01;32";
        ".zip" = "01;32";
        ".zoo" = "01;32";
        ".zst" = "01;32";

        #+--- Audio ---+;
        ".aac" = "32";
        ".au" = "32";
        ".flac" = "32";
        ".m4a" = "32";
        ".mid" = "32";
        ".midi" = "32";
        ".mka" = "32";
        ".mp3" = "32";
        ".mpa" = "32";
        ".ogg" = "32";
        ".opus" = "32";
        ".ra" = "32";
        ".wav" = "32";

        #+--- Customs ---+;
        ".3des" = "01;35";
        ".aes" = "01;35";
        ".gpg" = "01;35";
        ".pgp" = "01;35";

        #+--- Documents ---+;
        ".doc" = "32";
        ".docx" = "32";
        ".dot" = "32";
        ".odg" = "32";
        ".odp" = "32";
        ".ods" = "32";
        ".odt" = "32";
        ".otg" = "32";
        ".otp" = "32";
        ".ots" = "32";
        ".ott" = "32";
        ".pdf" = "32";
        ".ppt" = "32";
        ".pptx" = "32";
        ".xls" = "32";
        ".xlsx" = "32";

        #+--- Executables ---+;
        ".app" = "01;36";
        ".bat" = "01;36";
        ".btm" = "01;36";
        ".cmd" = "01;36";
        ".com" = "01;36";
        ".exe" = "01;36";
        ".reg" = "01;36";

        #+--- Ignores ---+;
        "*~" = "02;37";
        ".bak" = "02;37";
        ".BAK" = "02;37";
        ".log" = "02;37";
        ".LOG" = "02;37";
        ".old" = "02;37";
        ".OLD" = "02;37";
        ".orig" = "02;37";
        ".ORIG" = "02;37";
        ".swo" = "02;37";
        ".swp" = "02;37";

        #+--- Images ---+;
        ".bmp" = "32";
        ".cgm" = "32";
        ".dl" = "32";
        ".dvi" = "32";
        ".emf" = "32";
        ".eps" = "32";
        ".gif" = "32";
        ".jpeg" = "32";
        ".jpg" = "32";
        ".JPG" = "32";
        ".mng" = "32";
        ".pbm" = "32";
        ".pcx" = "32";
        ".pgm" = "32";
        ".png" = "32";
        ".PNG" = "32";
        ".ppm" = "32";
        ".pps" = "32";
        ".ppsx" = "32";
        ".ps" = "32";
        ".svg" = "32";
        ".svgz" = "32";
        ".tga" = "32";
        ".tif" = "32";
        ".tiff" = "32";
        ".xbm" = "32";
        ".xcf" = "32";
        ".xpm" = "32";
        ".xwd" = "32";
        ".yuv" = "32";

        #+--- Video ---+;
        ".anx" = "32";
        ".asf" = "32";
        ".avi" = "32";
        ".axv" = "32";
        ".flc" = "32";
        ".fli" = "32";
        ".flv" = "32";
        ".gl" = "32";
        ".m2v" = "32";
        ".m4v" = "32";
        ".mkv" = "32";
        ".mov" = "32";
        ".MOV" = "32";
        ".mp4" = "32";
        ".mpeg" = "32";
        ".mpg" = "32";
        ".nuv" = "32";
        ".ogm" = "32";
        ".ogv" = "32";
        ".ogx" = "32";
        ".qt" = "32";
        ".rm" = "32";
        ".rmvb" = "32";
        ".swf" = "32";
        ".vob" = "32";
        ".webm" = "32";
        ".wmv" = "32";
      };
    };

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
        name = "Iosevka Term";
        size = 12;
      };

      keybindings = {
        "ctrl+shift+c" = "copy_and_clear_or_interrupt";
        "ctrl+tab" = "next_window";
        "ctrl+shift+tab" = "previous_window";
        "ctrl+shift+8" = "launch --location=vsplit";
        "ctrl+shift+9" = "launch --location=hsplit";
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
        close_on_child_death = "yes";
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
        update_check_interval = 0;

        # vim-kitty-navigator config
        # allow_remote_control = true;
        # listen_on = "unix:@mykitty";
      };
    };
    zsh.shellGlobalAliases = { ssh = "kitty +kitten ssh"; };

    tmux = {
      enable = true;
      clock24 = true;
      keyMode = "vi";
      newSession = true;
      plugins = with pkgs.tmuxPlugins; [
        nord
        resurrect
        {
          plugin = sidebar;
          extraConfig = ''
            set -g @sidebar-tree-command 'exa --tree --level 2 --all --group-directories-first --noicons'
          '';
        }
      ];
      shell = "${pkgs.zsh}/bin/zsh";
    };

    direnv = {
      enable = true;

      nix-direnv.enable = true;
    };

    nix-index = {
      enable = true;
      enableFishIntegration = false;
    };
  };

  home.sessionVariables = { TERMINAL = "${pkgs.kitty}/bin/kitty"; };
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
