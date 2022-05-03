{ ... }:

{
  services.kmonad = {
    enable = true;
    configfiles = [ ./integrated.kbd ];
    optionalconfigs = [ ];
  };
}
