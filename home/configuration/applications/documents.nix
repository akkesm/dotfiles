{ config, pkgs, ... }:

{
  programs = {
    texlive = {
      enable = true;
      extraPackages = (tpkgs: { inherit (tpkgs) scheme-medium; });
    };

    zathura = {
      enable = true;
      
      options = {
        database = "sqlite";
        recolor = true;
        recolor-keephue = true;
        recolor-reverse-video = false;
        show-hidden = true;
        scroll-page-aware = true;
        window-title-home-tilde = true;
        window-title-page = true;
        statusbar-home-tilde = true;
        zoom-max = 500;
        selection-notification = false;
      };
    };
  };

  home.packages = [ pkgs.onlyoffice-bin ];
}
