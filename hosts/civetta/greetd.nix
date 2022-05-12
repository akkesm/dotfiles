{ config, pkgs, ... }:

{
  services.greetd = {
    enable = true;
    package = pkgs.greetd.greetd;
    settings = {
      default_session = {
        command = "${pkgs.greetd.greetd}/bin/agreety --cmd ${pkgs.zsh}/bin/zsh";
        user = "greeter";
      };

      initial_session = {
        command = "${pkgs.sway}/bin/sway";
        # command = "${pkgs.systemd}/bin/systemd-cat --identifier=sway ${pkgs.sway}/bin/sway";
        user = config.users.users.alessandro.name;
      };
    };
  };
}
