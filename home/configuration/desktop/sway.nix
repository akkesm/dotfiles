{ config, lib, pkgs, ... }:

# https://nixos.wiki/wiki/Sway

{
  home = {
    packages = with pkgs; [
      nordzy-cursors
      playerctl
    ];

    sessionVariables = {
      XDG_CURRENT_DESKTOP = "sway";
      ECORE_EVAS_ENGINE = "wayland_egl";
      ELM_ENGINE = "wayland_egl";
      SDL_VIDEODRIVER = "wayland";
      _JAVA_AWT_WM_NONREPARENTING = 1;
    };
  };

  # programs.zsh.profileExtra = ''
  #   if [ -z $DISPLAY ] && [ "$(tty)" = "/dev/tty1" ]; then
  #     # systemctl --user import-environment PATH LD_LIBRARY_PATH LIBEXEC_PATH GTK_PATH
  #     # exec systemctl --user start sway.service
  #     exec sway
  #   fi
  # '';

  systemd.user = {
    services.sway = {
      Unit = {
        Description = "Sway - Wayland window manager";
        Documentation = [ "man:sway(5)" ];
        BindsTo = [ "graphical-session.target" ];
        Wants = [ "graphical-session-pre.target" ];
        After = [ "graphical-session-pre.target" ];
      };

      Service = {
        Type = "simple";
        ExecStart = ''
          ${pkgs.dbus}/bin/dbus-run-session ${pkgs.sway}/bin/sway
        '';
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };

    sessionVariables = config.home.sessionVariables;
  };

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
        let mod = config.wayland.windowManager.sway.config.modifier;
        in lib.mkOptionDefault { "${mod}+Tab" = "workspace back_and_forth"; };

      keycodebindings = {
        "121" = "exec ${pkgs.pulseaudio}/bin/pactl set-sink-mute @DEFAULT_SINK@ toggle";
        "122" = "exec ${pkgs.pulseaudio}/bin/pactl set-sink-volume @DEFAULT_SINK@ -1%";
        "123" = "exec ${pkgs.pulseaudio}/bin/pactl set-sink-volume @DEFAULT_SINK@ +1%";
        "232" = "exec ${pkgs.brightnessctl}/bin/brightnessctl set 2%-";
        "233" = "exec ${pkgs.brightnessctl}/bin/brightnessctl set +2%";
      };

      output = {
        "*" = {
          background = "${../../..}/images/wallpaperNordNixLogo.png fill";
        };
      };

      seat = {
        "seat0" = {
          hide_cursor = "when-typing enable";
          xcursor_theme = "Nordzy-cursors 24";
        };
      };

      startup = [ { command = "${pkgs.brightnessctl}/bin/brightnessctl set 6%"; } ];
      terminal = "${pkgs.kitty}/bin/kitty";
    };

    extraConfig = ''
      for_window [app_id="^launcher$"] floating enable, sticky enable, resize set 30 ppt 50 ppt, border pixel 3
      for_window [class="^Pinentry$"] floating enable
    '';

    systemdIntegration = true;
  };
}
