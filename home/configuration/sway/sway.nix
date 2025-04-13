{ config, lib, pkgs, ... }:

# https://nixos.wiki/wiki/Sway

{
  home = {
    packages = with pkgs; [
      nordzy-cursor-theme
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

      floating = {
        border = 3;

        criteria = [
          { app_id = "^launcher$"; }

          {
            app_id = "firefox";
            title = "^About Mozilla Firefox$";
          }

          {
            app_id = "firefox";
            title = "^Picture-in-Picture$";
          }

          { class = "^Pinentry$"; }
          { title = "(?:Open|Save) (?:File|Folder|As)"; }
          { title = "(?:Copying|Moving|Deleting) .* Dolphin"; }
          { window_role = "bubble"; }
          { window_role = "dialog"; }
          { window_role = "pop-up"; }
        ];

        titlebar = false;
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
          xkb_options = "compose:rctrl-altgr";
        };

        "type:touchpad" = {
          click_method = "clickfinger";
          tap = "enabled";
          tap_button_map = "lrm";
        };
      };

      modifier = "Mod4";

      keybindings =
        let mod = config.wayland.windowManager.sway.config.modifier;
        in
        lib.mkOptionDefault {
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
        # "*".background = "${pkgs.plusultra.wallpapers.nord-rainbow-dark-nix} fill";
        "Microstep MSI G281UV CC8Q232600088".scale = "1.5";
      };

      seat = {
        "seat0" = {
          hide_cursor = "when-typing enable";
          xcursor_theme = "Nordzy-cursors 24";
        };
      };

      startup = [{ command = "${pkgs.brightnessctl}/bin/brightnessctl --quiet set 6%"; }];
      terminal = "${pkgs.kitty}/bin/kitty";

      window = {
        commands = [
          {
            command = "sticky enable";
            criteria.class = "^Pinentry$";
          }
          {
            command = "title_format '%title [XWayland]'";
            criteria.shell = "xwayland";
          }
          {
            command = "sticky enable, resize set 30 ppt 50 ppt";
            criteria.app_id = "^launcher$";
          }
          {
            command = "sticky enable";

            criteria = {
              app_id = "firefox";
              title = "^Picture-in-Picture$";
            };
          }
        ];

        titlebar = false;
      };
    };

    extraConfig = ''
      bindswitch lid:on output HDMI-A-1 enable
      bindswitch lid:off output HDMI-A-1 disable
    '';

    systemd.enable = true;
    wrapperFeatures.gtk = true;
  };
}
