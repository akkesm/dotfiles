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
        build = self.packages."${system}".default;
      });

      devShells.default = forAllSystems (system: with nixpkgsFor."${system}"; mkShell {
        packages = [ ];
      });
    };
}
