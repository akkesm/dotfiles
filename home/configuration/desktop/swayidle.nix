{ config, pkgs, ... }:

{
  services.swayidle = {
    enable = true;

    events = [
      {
        event = "lock";
        command = "${pkgs.swaylock}/bin/swaylock";
      }
      {
        event = "before-sleep";
        command = "${pkgs.playerctl}/bin/playerctl pause";
      }
      {
        event = "before-sleep";
        command = "${pkgs.swaylock}/bin/swaylock";
      }
      {
        event = "after-resume";
        command = "${pkgs.sway}/bin/swaymsg 'output * dpms on'";
      }
      {
        event = "after-resume";
        command = "${pkgs.brightnessctl}/bin/brightnessctl set 6%";
      }
    ];

    timeouts = [
      {
        timeout = 480;
        command = "${pkgs.brightnessctl}/bin/brightnessctl set 0%";
        resumeCommand = "${pkgs.brightnessctl}/bin/brightnessctl set 6%";
      }
      {
        timeout = 600;
        command = "${pkgs.sway}/bin/swaymsg 'output * dpms off'";
        resumeCommand = "${pkgs.sway}/bin/swaymsg 'output * dpms on' && ${pkgs.brightnessctl}/bin/brightnessctl set 6%";
      }
      {
        timeout = 605;
        command = "${pkgs.swaylock}/bin/swaylock";
      }
    ];
  };
}
