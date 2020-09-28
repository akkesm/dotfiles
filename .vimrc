if &cp | set nocp | endif
let s:cpo_save=&cpo
set cpo&vim
nmap <F3> i<C-R>=strftime("%Y-%m-%dT %I:%M %p")<CR><Esc>
imap <F3> <C-R>=strftime("%Y-%m-%dT%I:%M %p")<CR>
imap <C-J> <Plug>IMAP_JumpForward
inoremap <silent> <Plug>IMAP_JumpBack :call IMAP_Jumpfunc('b', 0)
inoremap <silent> <Plug>IMAP_JumpForward :call IMAP_Jumpfunc('', 0)
inoremap <C-U> u
map! <S-Insert> <MiddleMouse>
vmap <NL> <Plug>IMAP_JumpForward
nmap <NL> <Plug>IMAP_JumpForward
map Q gq
vmap gx <Plug>NetrwBrowseXVis
nmap gx <Plug>NetrwBrowseX
vnoremap <silent> <Plug>NetrwBrowseXVis :call netrw#BrowseXVis()
nnoremap <silent> <Plug>NetrwBrowseX :call netrw#BrowseX(expand((exists("g:netrw_gx")? g:netrw_gx : '<cfile>')),netrw#CheckIfRemote())
vmap <C-J> <Plug>IMAP_JumpForward
nmap <C-J> <Plug>IMAP_JumpForward
vnoremap <silent> <Plug>IMAP_JumpBack `<:call IMAP_Jumpfunc('b', 0)
vnoremap <silent> <Plug>IMAP_JumpForward :call IMAP_Jumpfunc('', 0)
vnoremap <silent> <Plug>IMAP_DeleteAndJumpBack "_<Del>:call IMAP_Jumpfunc('b', 0)
vnoremap <silent> <Plug>IMAP_DeleteAndJumpForward "_<Del>:call IMAP_Jumpfunc('', 0)
nnoremap <silent> <Plug>IMAP_JumpBack :call IMAP_Jumpfunc('b', 0)
nnoremap <silent> <Plug>IMAP_JumpForward :call IMAP_Jumpfunc('', 0)
map <S-Insert> <MiddleMouse>
imap <NL> <Plug>IMAP_JumpForward
inoremap  u
cmap ww w !sudo tee > /dev/null %
cmap W w
cmap Q q
let &cpo=s:cpo_save
unlet s:cpo_save
set autoindent
set background=dark
set backspace=indent,eol,start
set backupdir=~/.cache/vim/backup//
set cindent
set cmdheight=2
set confirm
set comments=b:#,:%,n:>
set confirm
set digraph
set directory=~/.cache/vim/swap//
set display=truncate
set fileencodings=ucs-bom,utf-8,default,latin1
set formatoptions=cqrt
set helplang=it
set history=200
set ignorecase
set incsearch
set langnoremap
set list listchars=tab:»·,trail:·
set noerrorbells
set noexpandtab
set nolangremap
set nostartofline
set number
set laststatus=2
set mouse=nvi
set nrformats=bin,hex
set ruler
set scrolloff=5
set shiftwidth=4
set showcmd
set smartcase
set softtabstop=4
set suffixes=.bak,~,.o,.info,.swp,.aux,.bbl,.blg,.brf,.cb,.dvi,.idx,.ilg,.ind,.inx,.jpg,.log,.out,.png,.toc
set tabstop=4
set termencoding=utf-8
set termguicolors
set ttimeout
set ttimeoutlen=100
set undodir=~/.cache/vim/undo//
" set visualbell
set whichwrap=h,l
set wildmenu
set window=38
" vim: set ft=vim :
syntax on
autocmd FileType make set tabstop=8 shiftwidth=8 softtabstop=0 noexpandtab

au BufWinEnter * normal zR


" REQUIRED. This makes vim invoke Latex-Suite when you open a tex file.
filetype plugin on

" OPTIONAL: This enables automatic indentation as you type.
filetype indent on

" OPTIONAL: Starting with Vim 7, the filetype of empty .tex files defaults to
" 'plaintex' instead of 'tex', which results in vim-latex not being loaded.
" The following changes the default filetype back to 'tex':
let g:tex_flavor='latex'



fun! SetupVAM()
	let c = get(g:, 'vim_addon_manager', {})
	let g:vim_addon_manager = c
	let c.plugin_root_dir = expand('$HOME', 1) . '/.vim/vim-addons'

	" Force your ~/.vim/after directory to be last in &rtp always:
	" let g:vim_addon_manager.rtp_list_hook = 'vam#ForceUsersAfterDirectoriesToBeLast'

	" most used options you may want to use:
	" let c.log_to_buf = 1
	" let c.auto_install = 0
	let &rtp.=(empty(&rtp)?'':',').c.plugin_root_dir.'/vim-addon-manager'
	if !isdirectory(c.plugin_root_dir.'/vim-addon-manager/autoload')
		execute '!git clone --depth=1 git://github.com/MarcWeber/vim-addon-manager '
					\       shellescape(c.plugin_root_dir.'/vim-addon-manager', 1)
	endif

	" This provides the VAMActivate command, you could be passing plugin names, too
	call vam#ActivateAddons([], {})
endfun
call SetupVAM()

" ACTIVATING PLUGINS

" OPTION 1, use VAMActivate
VAMActivate github:xuhdev/vim-latex-live-preview evince-synctex github:chriskempson/base16-vim github:vim-airline/vim-airline github:vim-airline/vim-airline-themes github:dawikur/base16-vim-airline-themes

let base16colorspace=256
colorscheme base16-black-metal-bathory

let g:airline_theme='base16'

autocmd Filetype tex setl updatetime=1000

let g:livepreview_engine='xelatex'
let g:tex_flavor='xelatex'
let g:Tex_CompileRule_pdf='xelatex --interaction=nonstopmode $*'
let g:Tex_CompileRule_dvi='xelatex --interaction=nonstopmode $*'
let g:Tex_DefaultTargetFormat='pdf'
let g:Tex_ViewRule_dvi='evince'


" Update compile command with bibliography
"        let b:livepreview_buf_data['run_cmd'] =
"               \       'env ' .
"               \               'TEXMFOUTPUT=' . l:tmp_root_dir . ' ' .
"                \               'TEXINPUTS=' . l:tmp_root_dir
"                \                            . ':' . b:livepreview_buf_data['root_dir']
"                \                            . ': ' .
"                \ ' && ' .
"                \       b:livepreview_buf_data['run_cmd'] .
"                \ ' && ' .
"                \       'cd ' . l:tmp_root_dir . ' && bibtex *.bcf' .
"                \ ' && ' .
"                \       b:livepreview_buf_data['run_cmd']
