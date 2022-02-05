{ config, pkgs, ... }:

let
  wlgreetSwayConfig = pkgs.writeText "wlgreet-sway-config" ''
    exec "${pkgs.greetd.wlgreet}/bin/wlgreet --command ${pkgs.sway}/bin/sway; ${pkgs.sway}/bin/swaymsg exit"

    bindsym Mod4+Shift+e exec swaynag \
    	-t warning \
    	-m 'What do you want to do?' \
    	-b 'Poweroff' 'systemctl poweroff' \
    	-b 'Reboot' 'systemctl reboot'
  '';
in
{
  environment.systemPackages = [ pkgs.wayland ];

  services.greetd = {
    enable = true;
    package = pkgs.greetd.greetd;
    settings = {
      default_session = {
        command = "${pkgs.greetd.greetd}/bin/agreety --cmd $SHELL";
        user = "greeter";
      };

      initial_session = {
        command = "${pkgs.systemd}/bin/systemd-cat --identifier=sway ${pkgs.sway}/bin/sway";
        user = config.users.users.alessandro.name;
      };
    };
  };
}
