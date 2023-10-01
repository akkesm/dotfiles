{ inputs, lib, rustPlatform, vimUtils }:

let
  inherit (lib.my) genDateVersion;
in
{
  dirbuf-nvim = vimUtils.buildVimPluginFrom2Nix {
    pname = "dirbuf.nvim";
    version = genDateVersion inputs.dirbuf-nvim;
    src = inputs.dirbuf-nvim;
  };

  due_nvim = vimUtils.buildVimPluginFrom2Nix {
    pname = "due_nvim";
    version = genDateVersion inputs.due_nvim;
    src = inputs.due_nvim;
  };

  neorg-telescope = vimUtils.buildVimPluginFrom2Nix {
    pname = "neorg-telescope";
    version = genDateVersion inputs.neorg-telescope;
    src = inputs.neorg-telescope;
  };

  nnn-nvim = vimUtils.buildVimPluginFrom2Nix {
    pname = "nnn-nvim";
    version = genDateVersion inputs.neorg-telescope;
    src = inputs.nnn-nvim;
  };

  vim-latex = {
    pname = "vim-latex";
    version = genDateVersion inputs.vim-latex;
    src = inputs.vim-latex;
  };
}
