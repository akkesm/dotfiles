{ mkShell
, nixpkgs-fmt
, sops
, ssh-to-pgp
, ssh-to-age
, sops-import-keys-hook
}:

mkShell {
  name = "sops-nix-secret-management";

  packages = [
    nixpkgs-fmt
    sops
    ssh-to-pgp
    ssh-to-age
    sops-import-keys-hook
  ];
}
