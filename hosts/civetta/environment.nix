{ config, pkgs, ... }:

{
  services = {
    printing = {
      enable = true;
      drivers = [ pkgs.gutenprint ];
      tempDir = "/tmp/cups";
    };
  };

  boot = {
    enableContainers = true;
    consoleLogLevel = 4;

    loader = {
      efi.canTouchEfiVariables = true;

      systemd-boot = {
        enable = true;
        consoleMode = "max";
        configurationLimit = 5;
        editor = false;
      };

      timeout = 5;
    };
  };

  documentation = {
    enable = true;
    dev.enable = true;
    man.generateCaches = true;
    nixos.includeAllModules = true;
  };

  # fonts = {
  #   enableDefaultFonts = true;

  #   fontconfig = {
  #     enable = true;
  #     cache32Bit = true;

  #     defaultFonts = {
  #       emoji = [ "twemoji-color-font" ];

  #       monospace = [
  #         "Iosevka Term"
  #         "Sarasa Mono SC"
  #       ];

  #       sansSerif = [
  #         "Meslo"
  #         "Iosevka"
  #         "Sarasa Gothic SC"
  #         "Unifont"
  #       ];

  #       serif = [
  #         "Roboto Slab"
  #       ];
  #     };
  #   };

  #   fonts = with pkgs; [
  #     (nerdfonts.override { fonts = [
  #      "FiraCode"
  #      "Iosevka"
  #     ]; })
  #     sarasa-gothic
  #     unifont

  #     liberation_ttf
  #     symbola
  #     vistafonts

  #     roboto-slab
  #   ];
  # };

  programs = {
    adb.enable = true; # Add users to "adbusers" group
    dconf.enable = true;
  };

  xdg.portal = {
    enable = true;
    wlr.enable = true;

    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-kde
    ];

    gtkUsePortal = true;
  };
}

