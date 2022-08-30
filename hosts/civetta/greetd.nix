{ config, pkgs, ... }:

{
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd.greetd}/bin/agreety --cmd ${pkgs.zsh}/bin/zsh";
        user = "greeter";
      };

      initial_session = {
        command = "sway";
        # command = "${pkgs.systemd}/bin/systemd-cat --identifier=sway sway";
        user = config.users.users.alessandro.name;
      };
    };
  };
}
