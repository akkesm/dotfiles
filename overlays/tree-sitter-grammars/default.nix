{ inputs, lib, callPackage }:

let
  inherit (lib.my) genDateVersion;
  buildGrammar = inputs.nixpkgs + "/pkgs/development/tools/parsing/tree-sitter/grammar.nix";
in
{
  tree-sitter-norg-meta = callPackage buildGrammar { } {
    language = "tree-sitter-norg-meta";
    version = genDateVersion inputs.tree-sitter-norg-meta;
    source = inputs.tree-sitter-norg-meta;
  };
  tree-sitter-norg-table = callPackage buildGrammar { } {
    language = "tree-sitter-norg-table";
    version = genDateVersion inputs.tree-sitter-norg-table;
    source = inputs.tree-sitter-norg-table;
  };
}
