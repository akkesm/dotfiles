{ mkShell
, deploy-rs
, fup-repl
, nixpkgs-fmt
, sops
, ssh-to-pgp
, ssh-to-age
, sops-import-keys-hook
}:

mkShell {
  name = "Manage dotfiles";

  packages = [
    deploy-rs
    fup-repl
    nixpkgs-fmt
    sops
    ssh-to-pgp
    ssh-to-age
    sops-import-keys-hook
  ];
}
