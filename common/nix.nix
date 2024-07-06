{ lib, pkgs, ... }:

{
  environment.variables.NIXPKGS_ALLOW_UNFREE = "1";

  nix = {
    package = pkgs.nixVersions.latest;
    settings = {
      auto-optimise-store = true;

      experimental-features = [
        "ca-derivations"
        "flakes"
        "nix-command"
        "recursive-nix"
      ];

      # preallocate-contents fixes btrfs compression, it is now disabled by default
      # keep-derivations (default true) and keep-outputs are for nix-direnv
      keep-outputs = true;

      substituters = lib.mkForce [
        "https://cache.ngi0.nixos.org"
        "https://cache.nixos.org"
        "https://nix-community.cachix.org"
        # "https://nixpkgs-wayland.cachix.org"
        "https://akkesm.cachix.org"
        # "https://digitallyinduced.cachix.org"
        # "https://cache.iog.io"
        # "https://nickel.cachix.org"
        # "https://nixcache.reflex-frp.org"
      ];

      trusted-public-keys = lib.mkForce [
        "cache.ngi0.nixos.org-1:KqH5CBLNSyX184S9BKZJo1LxrxJ9ltnY2uAs5c/f1MA="
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        # "nixpkgs-wayland.cachix.org-1:3lwxaILxMRkVhehr5StQprHdEo4IrE8sRho9R9HOLYA="
        "akkesm.cachix.org-1:9ESYmocqudg/QaRhELpkSWy4LNZbTqDdD2N0zpJP/e8="
        # "digitallyinduced.cachix.org-1:y+wQvrnxQ+PdEsCt91rmvv39qRCYzEgGQaldK26hCKE="
        # "hydra.iohk.io:f/Ea+s+dFdN+3Y/G+FDgSq+a5NEWhJGzdjvKNGv0/EQ="
        # "nickel.cachix.org-1:ABoCOGpTJbAum7U6c+04VbjvLxG9f0gJP5kYihRRdQs="
        # "ryantrinkle.com-1:JJiAKaRv9mWgpVAz8dwewnZe0AzzEAzPkagE9SP5NWI="
      ];

      trusted-users = [
        "root"
        "@wheel"
      ];
    };
  };

  nixpkgs.overlays = [
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
  ];
}
