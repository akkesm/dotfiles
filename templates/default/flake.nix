{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };

  outputs = { self, nixpkgs }:
    let
      supportedSystems = [ "x86_64-linux" ];
      forAllSystems = f: nixpkgs.lib.genAttrs supportedSystems (system: f system);

      nixpkgsFor = forAllSystems (system: import nixpkgs {
        inherit system;
        overlays = [ self.overlays.default ];
      });
    in
    {
      overlays.default = final: prev: {
        hello = prev.hello;
      };

      packages = forAllSystems (system: rec {
        inherit (nixpkgsFor."${system}") hello;
        default = hello;
      });

      checks = forAllSystems (system: {
        inherit (self.packages."${system}") default;
      });

      devShells = forAllSystems (system: with nixpkgsFor."${system}"; {
        default = mkShell {
          packages = [ ];
        };
      });
    };
}
