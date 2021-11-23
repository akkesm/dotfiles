{ config, pkgs, ... }:

{
  wayland.windowManager.sway.config.bars = [{
    command = "${pkgs.waybar}/bin/waybar";
    fonts = {
      names = [ config.fonts.sansSerif ];
      style = "Regular";
      size = 10.0;
    };
  }];

  programs.waybar = {
    enable = true;

    settings = [
      {
        layer = "top";
        position = "top";
        height = 24;

        modules-left = [
          "sway/workspaces"
          "sway/mode"
          "sway/window"
        ];

        modules-right = [
          "cpu"
          "memory"
          "disk"
          "network"
          "pulseaudio"
          "backlight"
          "battery"
          "tray"
          "clock"
        ];

        modules = {
          "cpu" = {
            interval = 11;
            format = "﬙ {usage}% {load}";
          };

          "memory" = {
            interval = 13;
            format = " {used:0.1f}/{total:0.1f}GiB";
          };

          "disk" = {
            interval = 127;
            format = " {used}/{total}";
          };

          "network" = {
            format-ethernet = " {ipaddr} {essid} {bandwidthDownBits}↓ {bandwidthUpBits}↑";
            format-wifi = "﬉ {ipaddr} {essid} {bandwidthDownBits}↓ {bandwidthUpBits}↑";
          };

          "pulseaudio" = {
            scroll-step = 2;
            format = "{icon} {volume}%";
            format-bluetooth = "{icon} {volume}% ";
            format-muted = "🔇 {volume}%";

            format-icons = {
              default = [ "" "" ];
              headphones = [ "" "" ];
              headset = "";
              phone = "";
              speaker = [ "🔈" "🔉" "🔊" ];
            };
          };

          "backlight" = {
            format = "{icon} {percent}%";
            format-icons = [ "○" "◍" "●" ];
          };

          "battery" = {
            interval = 59;
            format = "{icon} {capacity}% {time}";
            format-charging = " {capacity}% {time}";
            format-time = " {H}:{M}";
            format-icons = [ "" "" "" "" "" "" "" "" "" "" "" ];
          };

          "clock" = {
            format = " {:%Y-%m-%dT%H:%M}";
            today-format = "{%Y-%m-%d}";
          };
        };
      }
    ];

    style = ''
      * {
        border: none;
        border-radius: 0;
        font-family: monospace;
        font-size: 14px;
        min-height: 0;
      }

      window#waybar {
        background-color: #2e3440;
        border: none;
        color: #eceff4;
      }

      window#waybar.hidden {
      	opacity: 0.2;
      }

      #workspaces button {
        padding: 0 5px;
        background-color: #5e81ac;
        color: #eceff4;
      }

      #workspaces button:hover {
        box-shadow: inset 0 -2px #8fbcbb;
      }

      #workspaces button.focused {
        background-color: #88c0d0;
        box-shadow: inset 0 -3px #8fbcbb;
      }

      #workspaces button.urgent {
        background-color: #bf616a;
      }
      
      #cpu,
      #memory,
      #disk,
      #network,
      #battery,
      #backlight,
      #pulseaudio,
      #clock {
        color: #eceff4;
        margin: 0 2px;
        padding: 0 6px;
      }
      
      #window,
      #workspaces {
        margin: 0 4px 0 0;
      }
      
      #cpu {
        color: #88c0d0;
      }

      #memory {
        color: #8fbcbb;
      }

      #disk {
        color: #88c0d0;
      }

      #network {
        color: #8fbcbb;
      }

      #network.disconnected {
        color: #d08770;
      }

      #pulseaudio {
        color: #a3be8c;
      }

      #pulseaudio.muted {
        color: #b48ead;
      }

      #backlight {
        color: #81a1c1;
      }

      #battery {
        color: #5e81ac;
      }

      #battery.charging, #battery.plugged {
        color: #a3be8c;
      }

      @keyframes blink {
        to {
          background-color: #bf616a;
          color: #eceff4;
        }
      }
      
      #battery.critical:not(.charging) {
        background-color: #5e81ac;
        color: #eceff4;
        animation-name: blink;
        animation-duration: 0.5s;
        animation-timing-function: linear;
        animation-iteration-count: infinite;
        animation-direction: alternate;
      }

      #tray {
        color: #b48ead;
      }

      #tray > .passive {
        color: #ebcb8b
      }

      #tray > .active {
        color: #a3be8c
      }

      #tray > .needs-attention {
        color: #bf616a
      }

      #clock {
        background-color: #434c5e;
      }
    '';
  };
}
