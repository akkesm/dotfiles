vim.opt.autowrite = true
vim.opt.backup = true
vim.opt.backupcopy = 'yes'
vim.opt.breakindent = true
vim.opt.browsedir = 'current'
vim.opt.cindent = true
vim.opt.clipboard = 'unnamedplus'
vim.opt.cmdheight = 2
vim.opt.colorcolumn = { '70', '80', '100' }
vim.opt.completeopt = { 'menuone', 'noinsert', 'noselect' }
vim.opt.concealcursor = 'c'
vim.opt.conceallevel = 2
vim.opt.confirm = true
vim.opt.copyindent = true
vim.opt.cpoptions:append('fImnW')
vim.opt.expandtab = true
vim.opt.fileencoding = 'utf-8'
vim.opt.fileignorecase = false
vim.opt.formatoptions:append('nl')
vim.opt.fsync = true
vim.opt.guifont = 'Iosevka Nerd Font 12'
vim.opt.helplang = { 'it', 'en' }
vim.opt.history = 1000
vim.opt.hlsearch = false
vim.opt.ignorecase = true
vim.opt.inccommand = 'nosplit'
vim.opt.incsearch = true
vim.opt.joinspaces = true
vim.opt.laststatus = 3
vim.opt.linebreak = true
vim.opt.list = true
vim.opt.listchars = { tab = '»·', lead = '·', trail = '·', nbsp = '⍽' }
vim.opt.mouse = 'a'
vim.opt.mousehide = false
vim.opt.nrformats:append({ 'alpha' })
vim.opt.number = true
vim.opt.numberwidth = 5
vim.opt.pyxversion = 3
vim.opt.relativenumber = true;
vim.opt.ruler = true
vim.opt.scrolloff = 4
vim.opt.shada = { '!', "'100", '<100', 'h', 'r/mnt', 'r/tmp', 's100' }
vim.opt.shiftwidth = 4
vim.opt.shortmess:append('Ic')
vim.opt.showbreak = '+++ '
vim.opt.showcmd = true
vim.opt.showmode = true
vim.opt.smartcase = true
vim.opt.smarttab = true
vim.opt.softtabstop = 2
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.swapfile = true
vim.opt.tabstop = 4
vim.opt.termguicolors = true
vim.opt.undofile = true
vim.opt.undolevels = 50
vim.opt.virtualedit = 'block'
vim.opt.wildignorecase = true

vim.keymap.set('c', 'ww', 'w !sudo tee % > /dev/null', { noremap = true })
vim.keymap.set('n', '<Leader>fmt', function() vim.lsp.buf.format { async = true } end, { noremap = true, silent = true })
vim.keymap.set('n', '<Leader>n', ":noh<CR>", { noremap = true, silent = true })

vim.cmd([[
    augroup indentation
        autocmd!
        autocmd FileType c,make setlocal noexpandtab shiftwidth=8 softtabstop=8 tabstop=8
        autocmd FileType json,nix setlocal shiftwidth=2 tabstop=2
        autocmd FileType markdown,norg setlocal shiftwidth=2
        autocmd FileType tex setlocal iskeyword+=: shiftwidth=2
    augroup END

    augroup zig
        autocmd!
        autocmd BufNewFile main.zig 0put = 'const std = @import(\"std\");'
        autocmd BufNewFile main.zig 2
        autocmd BufEnter *.zig compile zig
    augroup END

    augroup gopass
        autocmd!
        autocmd BufNewFile,BufRead /dev/shm/gopass.* setlocal noswapfile nobackup noundofile
    augroup END
]])
