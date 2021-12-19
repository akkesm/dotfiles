# nix shell nixpkgs#perl534Packages.CPANPLUS nixpkgs#perl534Packages.CPAN nixpkgs#perl534Packages.GetoptLong nixpkgs#perl534Packages.JSON nixpkgs#perl534Packages.LogLog4perl nixpkgs#perl534Packages.Readonly nixpkgs#nix-generate-from-cpan -c nix-generate-from-cpan Package::Name

{ lib, perlPackages, fetchurl }:

with perlPackages;

rec {
  ClassRefresh = buildPerlPackage {
    pname = "Class-Refresh";
    version = "0.07";
    src = fetchurl {
      url = "mirror://cpan/authors/id/D/DO/DOY/Class-Refresh-0.07.tar.gz";
      sha256 = "e3b0035355cbb35a2aee3f223688d578946a7a7c570acd398b28cddb1fd4beb3";
    };
    buildInputs = [ TestFatal TestRequires ];
    propagatedBuildInputs = [ ClassLoad ClassUnload DevelOverrideGlobalRequire TryTiny ];
    meta = {
      homepage = "http://metacpan.org/release/Class-Refresh";
      description = "Refresh your classes during runtime";
      license = with lib.licenses; [ artistic1 gpl1Plus ];
    };
  };

  CompilerLexer = buildPerlModule {
    pname = "Compiler-Lexer";
    version = "0.23";
    src = fetchurl {
      url = "mirror://cpan/authors/id/G/GO/GOCCY/Compiler-Lexer-0.23.tar.gz";
      sha256 = "6031ce4afebbfa4f492a274949be7b8232314e91023828c438e47981ff0a99db";
    };
    buildInputs = [ ModuleBuildXSUtil ];
    perlPreHook = "export LD=$CC";
    meta = {
      homepage = "https://github.com/goccy/p5-Compiler-Lexer";
      description = "Lexical Analyzer for Perl5";
      license = with lib.licenses; [ artistic1 gpl1Plus ];
    };
  };

  DevelOverrideGlobalRequire = buildPerlPackage {
    pname = "Devel-OverrideGlobalRequire";
    version = "0.001";
    src = fetchurl {
      url = "mirror://cpan/authors/id/D/DA/DAGOLDEN/Devel-OverrideGlobalRequire-0.001.tar.gz";
      sha256 = "0791892de3ae292af4a94e382f21db1ee88210875031851e6ea82c3410785ef9";
    };
    meta = {
      homepage = "https://metacpan.org/release/Devel-OverrideGlobalRequire";
      description = "Override CORE::GLOBAL::require safely";
      license = with lib.licenses; [ artistic1 gpl1Plus ];
    };
  };

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

  Perl-LanguageServer = buildPerlPackage {
    pname = "Perl-LanguageServer";
    version = "2.3.0";
    src = fetchurl {
      url = "mirror://cpan/authors/id/G/GR/GRICHTER/Perl-LanguageServer-2.3.0.tar.gz";
      sha256 = "d4ad56e69d59e2ff1f20d9c21cf9c4ce7ef993cf8d684d30a2849923c0e15c88";
    };
    propagatedBuildInputs = [ AnyEvent AnyEventAIO ClassRefresh CompilerLexer Coro DataDump IOAIO JSON Moose PadWalker ];
    meta = {
      description = "Language Server and Debug Protocol Adapter for Perl";
      license = lib.licenses.artistic2;
    };
  };
}
