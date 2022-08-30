{ inputs, lib, rustPlatform, vimUtils }:

let
  inherit (lib.my) genDateVersion;
in
{
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

  neorg-telescope = vimUtils.buildVimPluginFrom2Nix {
    pname = "neorg-telescope";
    version = genDateVersion inputs.neorg-telescope;
    src = inputs.neorg-telescope;
    meta.homepage = inputs.neorg-telescope.url;
  };

  vim-latex = {
    pname = "vim-latex";
    version = genDateVersion inputs.vim-latex;
    src = inputs.vim-latex;
    meta.homepage = inputs.vim-latex.url;
  };
}
