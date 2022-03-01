{ config, lib, pkgs, ... }:

# https://nixos.wiki/wiki/Sway

{
  home = {
    packages = with pkgs; [
      nordzy-cursors
      playerctl
    ];

    sessionVariables = {
      ECORE_EVAS_ENGINE = "wayland_egl";
      ELM_ENGINE = "wayland_egl";
      NIXOS_OZONE_WL = 1;
      QT_QPA_PLATFORM = "wayland-egl";
      SDL_VIDEODRIVER = "wayland";
      XDG_CURRENT_DESKTOP = "sway";
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
      assigns."2" = [{ app_id = "firefox"; }];
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
        in lib.mkOptionDefault {
          "${mod}+Tab" = "workspace back_and_forth";
          "${mod}+z" = "exec bluetoothctl power on";
          "${mod}+Shift+z" = "exec bluetoothctl power off";
        };

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
      for_window {
        [shell="xwayland"] title_format "%title [XWayland]"
        [window_role="pop-up"] floating enable
        [window_role="bubble"] floating enable
        [window_role="dialog"] floating enable
        [window_type="dialog"] floating enable
        [title="(?:Open|Save) (?:File|Folder|As)"] floating enable
        [app_id="^launcher$"] floating enable, sticky enable, resize set 30 ppt 50 ppt, border pixel 3
        [class="^Pinentry$"] floating enable
        [app_id="firefox" title="^Picture-in-Picture$"] floating enable, sticky enable
        [app_id="firefox" title="^About Mozilla Firefox$"] floating enable
      }
    '';

    systemdIntegration = true;
    wrapperFeatures.gtk = true;
  };
}
