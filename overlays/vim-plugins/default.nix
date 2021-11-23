{ inputs, lib, vimUtils }:

{
  # COQ plugins are updated every day, autogenerate the version
  coq_nvim = vimUtils.buildVimPluginFrom2Nix {
    pname = "coq_nvim";
    version = with lib; builtins.head (
      splitString " " (
        last (
          splitString
            "\n"
            (fileContents "${inputs.coq_nvim}/.github/.agp")
        )
      )
    );
    src = inputs.coq_nvim;
    meta.homepage = inputs.coq_nvim.url;
  };

  coq_artifacts = vimUtils.buildVimPluginFrom2Nix {
    pname = "coq_artifacts";
    version = with lib; builtins.head (
      splitString " " (
        last (
          splitString
            "\n"
            (fileContents "${inputs.coq_artifacts}/.github/.agp")
        )
      )
    );
    src = inputs.coq_artifacts;
    meta.homepage = inputs.coq_artifacts.url;
  };

  coq_thirdparty = vimUtils.buildVimPluginFrom2Nix {
    pname = "coq_thirdparty";
    version = with lib; builtins.head (
      splitString " " (
        last (
          splitString
            "\n"
            (fileContents "${inputs.coq_thirdparty}/.github/.agp")
        )
      )
    );
    src = inputs.coq_thirdparty;
    meta.homepage = inputs.coq_thirdparty.url;
  };

  due_nvim = vimUtils.buildVimPluginFrom2Nix {
    pname = "due_nvim";
    version = "2021-07-04";
    src = inputs.due_nvim;
    meta.homepage = inputs.due_nvim.url;
  };

  nabla-nvim = vimUtils.buildVimPluginFrom2Nix {
    pname = "nabla.nvim";
    version = "2021-10-20";
    src = inputs.nabla-nvim;
    meta.homepage = inputs.nabla-nvim.url;
  };

  neorg-telescope = vimUtils.buildVimPluginFrom2Nix {
    pname = "neorg-telescope";
    version = "2021-08-18";
    src = inputs.neorg-telescope;
    meta.homepage = inputs.neorg-telescope.url;
  };

  nvim-workbench = vimUtils.buildVimPluginFrom2Nix {
    pname = "nvim-workbench";
    version = "2021-07-12";
    src = inputs.nvim-workbench;
    meta.homepage = inputs.nvim-workbench.url;
  };

  vim-latex = {
    pname = "vim-latex";
    version = "2021-08-18";
    src = inputs.vim-latex;
    meta.homepage = inputs.vim-latex.url;
  };

  windline-nvim = {
    pname = "windline.nvim";
    version = "2021-10-21";
    src = inputs.windline-nvim;
    meta.homepage = inputs.windline-nvim.url;
  };
}
