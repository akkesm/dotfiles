{ inputs, lib, rustPlatform, vimUtils }:

let
  inherit (lib.my) genDateVersion;
in
{
  coq_nvim = vimUtils.buildVimPluginFrom2Nix {
    pname = "coq_nvim";
    version = genDateVersion inputs.coq_nvim;
    src = inputs.coq_nvim;
    meta.homepage = inputs.coq_nvim.url;
  };

  coq_artifacts = vimUtils.buildVimPluginFrom2Nix {
    pname = "coq_artifacts";
    version = genDateVersion inputs.coq_artifacts;
    src = inputs.coq_artifacts;
    meta.homepage = inputs.coq_artifacts.url;
  };

  coq_thirdparty = vimUtils.buildVimPluginFrom2Nix {
    pname = "coq_thirdparty";
    version = genDateVersion inputs.coq_thirdparty;
    src = inputs.coq_thirdparty;
    meta.homepage = inputs.coq_thirdparty.url;
  };

  dirbuf-nvim = vimUtils.buildVimPluginFrom2Nix {
    pname = "dirbuf.nvim";
    version = genDateVersion inputs.dirbuf-nvim;
    src = inputs.dirbuf-nvim;
    meta.homepage = inputs.dirbuf-nvim.url;
  };

  due_nvim = vimUtils.buildVimPluginFrom2Nix {
    pname = "due_nvim";
    version = genDateVersion inputs.due_nvim;
    src = inputs.due_nvim;
    meta.homepage = inputs.due_nvim.url;
  };

  nabla-nvim = vimUtils.buildVimPluginFrom2Nix {
    pname = "nabla.nvim";
    version = genDateVersion inputs.nabla-nvim;
    src = inputs.nabla-nvim;
    meta.homepage = inputs.nabla-nvim.url;
  };

  neorg-telescope = vimUtils.buildVimPluginFrom2Nix {
    pname = "neorg-telescope";
    version = genDateVersion inputs.neorg-telescope;
    src = inputs.neorg-telescope;
    meta.homepage = inputs.neorg-telescope.url;
  };

  nvim-compleet =
    let
      version = genDateVersion inputs.nvim-compleet;
      src = inputs.nvim-compleet;
      nvim-compleet-lib = rustPlatform.buildRustPackage rec {
        pname = "nvim-compleet-lib";
        inherit version src;
        buildType = "release";
        cargoDepsName = pname;
        cargoSha256 = "0zw6jp9xajr193z1z89piwmhrdhb0b6327p4a9kw3d535x6r377y";
        outputs = [ "out" "dev" ];
        postInstall = ''
          mkdir -p $dev/deps
          cp ./target/*/${buildType}-tmp/deps/*.rlib $dev/deps
        '';
      };
    in
    vimUtils.buildVimPluginFrom2Nix {
      pname = "nvim-compleet";
      inherit version src;

      postInstall = ''
        mkdir -p $target/lua
        ln -s "${nvim-compleet-lib}/lib/libcompleet.so" $target/lua/compleet.so
        ln -s "${nvim-compleet-lib.dev}/deps" $target/lua
      '';

      meta.homepage = inputs.nvim-compleet.url;
    };

  nvim-workbench = vimUtils.buildVimPluginFrom2Nix {
    pname = "nvim-workbench";
    version = genDateVersion inputs.nvim-workbench;
    src = inputs.nvim-workbench;
    meta.homepage = inputs.nvim-workbench.url;
  };

  vim-latex = {
    pname = "vim-latex";
    version = genDateVersion inputs.vim-latex;
    src = inputs.vim-latex;
    meta.homepage = inputs.vim-latex.url;
  };

  windline-nvim = vimUtils.buildVimPluginFrom2Nix {
    pname = "windline.nvim";
    version = genDateVersion inputs.windline-nvim;
    src = inputs.windline-nvim;
    meta.homepage = inputs.windline-nvim.url;
  };
}
