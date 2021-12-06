" set autochdir
set autoindent
set autowrite
set backup
set backupcopy=yes
set backupdir=$XDG_DATA_HOME/nvim/backup
set breakindent
set browsedir=buffer
set cindent
set clipboard+=unnamedplus
set cmdheight=2
set colorcolumn=70,80,100
set completeopt=menuone,noinsert,noselect
set concealcursor=c
set conceallevel=2
set confirm
set copyindent
set cpoptions=aABcefFImnsW_
set expandtab
set fileencoding=utf-8
set nofileignorecase
set formatoptions+=nl
set fsync
set guifont=Iosevka\ Term\ 12
set helplang=it,en
set history=1000
set hlsearch
set ignorecase
set inccommand=nosplit
set incsearch
set joinspaces
set linebreak
set list
set listchars=tab:»·,lead:·,trail:·,nbsp:⍽
set mouse=a
set nomousehide
set number
set numberwidth=5
set pyxversion=3
set relativenumber
set ruler
set scrolloff=3
set shada=!,'100,<1000,h,r/mnt,s100
set shiftwidth=4
set shortmess=cfilnxtToO
set showbreak="+++ "
set showcmd
set showmode
set smartcase
set smarttab
set softtabstop=2
set splitbelow
set splitright
set swapfile
set tabstop=4
set termguicolors
set undofile
set undolevels=500
set virtualedit=block
set wildignorecase
cnoremap ww w !sudo tee % >/dev/null
nnoremap <silent> <Leader>n :noh<CR>
nnoremap <silent> <Leader>fmt <Cmd>lua vim.lsp.buf.formatting()<CR>

"turn on hlsearch only while searching
"augroup vimrc-incsearch-highlight
"	autocmd!
"	autocmd CmdlineEnter /,\? :set hlsearch
"	autocmd CmdlineLeave /,\? :set nohlsearch
"augroup END

let base16colorspace=256

autocmd FileType json,nix setlocal shiftwidth=2 softtabstop=2 tabstop=2
autocmd FileType norg setlocal shiftwidth=2 tabstop=4
