{ pkgs, ... }:

{
  programs.neovim.plugins = [{
    plugin = pkgs.vimPlugins.chad;
    config = ''
      let g:chadtree_settings = {
      \ 'xdg': v:true,
      \ 'ignore.name_exact': [],
      \ 'view': {
      \   'sort_by': [ 'is_folder', 'file_name', 'ext' ],
      \   'width': 30
      \ },
      \ 'theme.text_colour_set' : 'nord'
      \}

      nnoremap <Leader>t <Cmd>CHADopen<CR>

      " Start CHADTree when Vim starts with a directory argument
      autocmd StdinReadPre * let s:std_in=1
      autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists('s:std_in') |
      \ execute 'CHADopen' argv()[0] | wincmd p | enew | execute 'cd '.argv()[0] | endif
    '';
  }];
}
