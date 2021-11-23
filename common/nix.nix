{ config, lib, pkgs, ... }:

{
  nix = {
    package = pkgs.nixUnstable;
    autoOptimiseStore = true;

    binaryCachePublicKeys = lib.mkForce [
      "cache.ngi0.nixos.org-1:KqH5CBLNSyX184S9BKZJo1LxrxJ9ltnY2uAs5c/f1MA="
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "nixpkgs-wayland.cachix.org-1:3lwxaILxMRkVhehr5StQprHdEo4IrE8sRho9R9HOLYA="
      "akkesm.cachix.org-1:9ESYmocqudg/QaRhELpkSWy4LNZbTqDdD2N0zpJP/e8="
      # "ryantrinkle.com-1:JJiAKaRv9mWgpVAz8dwewnZe0AzzEAzPkagE9SP5NWI="
    ];

    binaryCaches = lib.mkForce [
      "https://cache.ngi0.nixos.org"
      "https://cache.nixos.org"
      "https://nix-community.cachix.org"
      "https://nixpkgs-wayland.cachix.org"
      "https://akkesm.cachix.org"
      # "https://nixcache.reflex-frp.org"
    ];

    # preallocate-contents fixes compression
    # keep-* is for direnv and some other stuff
    extraOptions = ''
      experimental-features = nix-command flakes ca-derivations ca-references
      preallocate-contents = false

      keep-derivations = true
      keep-outputs = true
    '';

    trustedUsers = [
      "root"
      "@wheel"
    ];
  };

  nixpkgs = {
    config = {
      allowUnfree = true;
      contentAddressableByDefault = 1;
    };

    overlays = [
      # Iosevka custom build
      (final: prev: {
        iosevka-custom-term-ss04 = prev.iosevka.override {
          set = "custom-term-ss04";
          privateBuildPlan = {
            family = "Iosevka Custom Term";
            spacing = "term";
            serifs = "sans";
            no-cv-ss = false;
            export-glyph-names = true; # Needed for Kitty

            ligations = {
              inherits = "dlig";
            };

            variants = {
              inherits = "ss04";

              design = {
                capital-i = "short-serifed";
                capital-k = "symmetric-touching-serifless";
                i = "hooky";
                k = "straight-serifless";
                r = "compact";
                y = "straight";
                capital-gamma = "top-right-serifed";
                lower-iota = "flat-tailed";
                lower-lambda = "straight";
                cyrl-capital-ka = "straight-serifless";
                cyrl-el = "straight";
                zero = "dotted";
                one = "nobase";
                seven = "curly-serifless";
                tilde = "low";
                asterisk = "penta-high";
                underscore = "high";
                paragraph-sign = "low";
                caret = "high";
                ampersand = "closed";
                at = "fourfold";
              };
            };
          };
        };
      })
      # (final: prev: {
      #   iosevka-custom-term-ss04 = prev.iosevka-custom-term-ss04.overrideAttrs (oldAttrs: {
      #     buildPhase = ''
      #         runHook preBuild
      #         npm run build --no-update-notifier -- --jCmd=8  ttf::$pname >/dev/null
      #         runHook postBuild
      #       '';
      #   });
      # })

      # (final: prev: {
      #   lbry = prev.lbry.overrideAttrs (oldAttrs: rec {
      #     version = "0.51.2";
      #     src = prev.appimageTools.extract {
      #       inherit (oldAttrs) name;
      #       src = prev.fetchurl {
      #         url = "https://github.com/lbryio/lbry-desktop/releases/download/v${version}/LBRY_${version}.AppImage";
      #         sha512 = "EUM5k8D0OYYb01oWjVdBlWvwbZXcOa+mwL0WEDYxxPFRQQ+hLl1JsxZiqg3WCtSAACyutpTb4Rh2SotOSRT15A==";
      #       };
      #     };
      #   });
      # })

      # (import (builtins.fetchTarball {
      #   url = "https://github.com/akkesm/Passky-Desktop/archive/flake-fix.tar.gz";
      # }))
    ];
  };
}
