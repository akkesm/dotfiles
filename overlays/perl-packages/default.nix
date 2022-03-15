# nix shell nixpkgs#perl534Packages.CPANPLUS nixpkgs#perl534Packages.CPAN nixpkgs#perl534Packages.GetoptLong nixpkgs#perl534Packages.JSON nixpkgs#perl534Packages.LogLog4perl nixpkgs#perl534Packages.Readonly nixpkgs#nix-generate-from-cpan -c nix-generate-from-cpan Package::Name

{ lib, perlPackages, fetchurl }:

with perlPackages;

rec {
  EvalSafe = buildPerlPackage {
    pname = "Eval-Safe";
    version = "0.02";
    src = fetchurl {
      url = "mirror://cpan/authors/id/M/MA/MATHIAS/Eval-Safe/Eval-Safe-0.02.tar.gz";
      sha256 = "55a52c233e2dae86113f9f19b34f617edcfc8416f9bece671267bd1811b12111";
    };
    outputs = [ "out" "dev" ]; # no "devdoc"
    meta = {
      description = "Simplified safe evaluation of Perl code";
      license = lib.licenses.mit;
    };
  };

  MsgPackRaw = buildPerlPackage {
    pname = "MsgPack-Raw";
    version = "0.05";
    src = fetchurl {
      url = "mirror://cpan/authors/id/J/JA/JACQUESG/MsgPack-Raw-0.05.tar.gz";
      sha256 = "8559e2b64cd98d99abc666edf2a4c8724c9534612616af11f4eb0bbd0d422dac";
    };
    buildInputs = [ TestPod TestPodCoverage ];
    meta = {
      description = "Perl bindings to the msgpack C library";
      license = with lib.licenses; [ artistic1 gpl1Plus ];
    };
  };

  NeovimExt = buildPerlPackage {
    pname = "Neovim-Ext";
    version = "0.05";
    src = fetchurl {
      url = "mirror://cpan/authors/id/J/JA/JACQUESG/Neovim-Ext-0.05.tar.gz";
      sha256 = "9f3d91b040ed218b4d9523708c680533b33b4e81efcaf3e6c01ae51da2bfdd2c";
    };
    buildInputs = [ ArchiveZip FileSlurper FileWhich ProcBackground TestPod TestPodCoverage ];
    propagatedBuildInputs = [ ClassAccessor EvalSafe IOAsync MsgPackRaw ];
    doCheck = false; # the TestNvim module tries to download Neovim
    meta = {
      description = "Perl bindings for neovim";
      license = with lib.licenses; [ artistic1 gpl1Plus ];
    };
  };
}
