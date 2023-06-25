{ mkShell
, deploy-rs
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
    nixpkgs-fmt
    sops
    ssh-to-pgp
    ssh-to-age
    sops-import-keys-hook
  ];
}
