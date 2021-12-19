{ config, pkgs, ... }:

{
  systemd.user.services.swayidle = {
    Unit = {
      Description = "Idle Manager for Wayland";
      Documentation = [ "man:swayidle(1)" ];
      PartOf = [ "graphical-session.target" ];
    };

    Install = { WantedBy = [ "sway-session.target" ]; };

    Service = {
      Type = "simple";
      ExecStart = ''
        ${pkgs.swayidle}/bin/swayidle -w \
          timeout 480 "${pkgs.brightnessctl}/bin/brightnessctl set 0%" \
          timeout 600 "${pkgs.sway}/bin/swaymsg 'output * dpms off'" \
          timeout 605 "${pkgs.swaylock}/bin/swaylock" \
          resume "${pkgs.sway}/bin/swaymsg 'output * dpms on'" \
          resume "${pkgs.brightnessctl}/bin/brightnessctl set 6%" \
          before-sleep "${pkgs.playerctl}/bin/playerctl pause" \
          before-sleep "${pkgs.swaylock}/bin/swaylock"
      '';
    };
  };
}
