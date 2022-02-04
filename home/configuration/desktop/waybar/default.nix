{ config, lib, ... }:

{
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
          # "cpu"
          # "memory"
          # "disk"
          "network"
          "pulseaudio"
          "backlight"
          "battery"
          "tray"
          "clock"
        ];

        cpu = {
          interval = 11;
          format = "﬙ {usage}% {load}";
        };

        memory = {
          interval = 13;
          format = " {used:0.1f}/{total:0.1f}GiB";
        };

        disk = {
          interval = 127;
          format = " {used}/{total}";
        };

        network = {
          format-ethernet = " {ipaddr} {essid}";
          format-wifi = "﬉ {ipaddr} {essid}";
          format-disconnected = " {ifname} disconnected";
        };

        pulseaudio = {
          scroll-step = 2;
          format = "{icon} {volume}%";
          format-bluetooth = "{icon} {volume}% ";
          format-muted = "🔇 {volume}%";

          format-icons = {
            default = [ "" "" ];
            headphone = [ "" "" ];
            headset = "";
            phone = "";
            speaker = [ "🔈" "🔉" "🔊" ];
          };
        };

        backlight = {
          format = "{icon} {percent}%";
          format-icons = [ "○" "◍" "●" ];
        };

        battery = {
          interval = 23;
          format = "{icon} {capacity}% {time}";
          format-charging = " {capacity}% {time}";
          format-time = " {H}:{M}";
          format-icons = [ "" "" "" "" "" "" "" "" "" "" "" ];
        };

        clock = {
          format = " {:%Y-%m-%dT%H:%M}";
          today-format = "{%Y-%m-%d}";
        };
      }
    ];

    style = builtins.readFile ./style.css;
    systemd.enable = true;
  };

  systemd.user.targets.tray = {
    Unit = {
      Description = "Home Manager System Tray";
      Requires = [ "graphical-session-pre.target" ];
    };
  };

  wayland.windowManager.sway.config.bars = [];
  # [{
  #   command = "${pkgs.waybar}/bin/waybar";
  #   fonts = {
  #     names = [ config.fonts.sansSerif ];
  #     style = "Regular";
  #     size = 10.0;
  #   };
  # }];
}
