{ inputs, lib, vimUtils }:

let
  genDateVersion = input:
    lib.concatStringsSep "-" [
      (builtins.substring 0 4 input.lastModifiedDate)
      (builtins.substring 4 2 input.lastModifiedDate)
      (builtins.substring 7 2 input.lastModifiedDate)
    ];
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

  windline-nvim = {
    pname = "windline.nvim";
    version = genDateVersion inputs.windline-nvim;
    src = inputs.windline-nvim;
    meta.homepage = inputs.windline-nvim.url;
  };
}
