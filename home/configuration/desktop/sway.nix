{ config, lib, pkgs, ... }:

{
  programs.zsh.profileExtra = ''
    if [ -z $DISPLAY ] && [ "$(tty)" = "/dev/tty1" ]; then
      exec sway
    fi
  '';

  wayland.windowManager.sway = {
    enable = true;

    config = {
      bindkeysToCode = true;

      colors = {
        background = "#2e3440";

        focused = {
          background = "#2e3440";
          border = "#3b4252";
          childBorder = "#81a1c1";
          indicator = "#b48ead";
          text = "#eceff4";
        };
      };

      fonts = {
        names = [ config.fonts.sansSerif ];
        style = "Regular";
        size = 10.0;
      };

      input = {
        "type:keyboard" = {
          repeat_delay = "300";
          xkb_layout = "it";
        };

        "type:touchpad" = {
          tap = "enabled";
          tap_button_map = "lrm";
        };
      };
      modifier = "Mod4";

      keybindings = 
      let
        mod = config.wayland.windowManager.sway.config.modifier;
      in lib.mkOptionDefault {
        "${mod}+b" = "exec firefox";
        "${mod}+p" = "exec clipman pick -t wofi";
      };

      keycodebindings = {
        "121" = "exec ${pkgs.pulseaudio}/bin/pactl set-sink-mute @DEFAULT_SINK@ toggle";
        "122" = "exec ${pkgs.pulseaudio}/bin/pactl set-sink-volume @DEFAULT_SINK@ -1%";
        "123" = "exec ${pkgs.pulseaudio}/bin/pactl set-sink-volume @DEFAULT_SINK@ +1%";
        "232" = "exec ${pkgs.brightnessctl}/bin/brightnessctl set 2%-";
        "233" = "exec ${pkgs.brightnessctl}/bin/brightnessctl set +2%";
      };

      menu = "${pkgs.kitty}/bin/kitty --class=launcher -e ${pkgs.sway-launcher-desktop}/bin/sway-launcher-desktop";

      output = {
        "*" = {
          # I could pass ${self} here
          background = "${../../..}/images/wallpaperNordNixLogo.png fill";
        };
      };

      seat = {
        "seat0" = {
          hide_cursor = "when-typing enable";
          xcursor_theme = "Nordzy-cursors";
        };
      };

      startup = [
        {
          command = ''
            swayidle -w \
              timeout 480 "${pkgs.brightnessctl}/bin/brightnessctl set 1%" \
              timeout 600 'swaymsg "output * dpms off' \
              timeout 605 "${pkgs.swaylock}/bin/swaylock" \
              resume 'swaymsg "output * dpms on"' \
              resume '${pkgs.brightnessctl}/bin/brightnessctl set 6%' \
              before-sleep "${pkgs.playerctl}/bin/playerctl pause" \
              before-sleep "${pkgs.swaylock}/bin/swaylock"
          '';
        }
        { command = "wl-paste -t text --watch clipman store"; }
        { command = "${pkgs.brightnessctl}/bin/brightnessctl set 6%"; }
      ];

      terminal = "${pkgs.kitty}/bin/kitty";
    };

    extraConfig = ''
      for_window [app_id="^launcher$"] floating enable, sticky enable, resize set 30 ppt 60 ppt, border pixel 4
    '';

    wrapperFeatures.gtk = true;
    xwayland = true;
  };

  home.sessionVariables = {
    XDG_CURRENT_DESKTOP = "sway";
    ECORE_EVAS_ENGINE = "wayland_egl";
    ELM_ENGINE = "wayland_egl";
    QT_QPA_PLATFORM = "wayland-egl";
    QT_WAYLAND_FORCE_DPI = 100;
    SDL_VIDEODRIVER = "wayland";
    # _JAVA_AWT_WM_NONREPARENTING = 1;
  };

  home.packages = with pkgs; [
    clipman
    nordzy-cursors
    playerctl
    qt5.qtwayland
    swayidle
    wl-clipboard
  ];
}
