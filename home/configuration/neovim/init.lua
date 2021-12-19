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
vim.opt.linebreak = true
vim.opt.list = true
vim.opt.listchars = { tab = '»·', lead = '·', trail = '·', nbsp = '⍽' }
vim.opt.mouse = 'a'
vim.opt.mousehide = false
vim.opt.number = true
vim.opt.numberwidth = 5
vim.opt.pyxversion = 3
vim.opt.relativenumber = true;
vim.opt.ruler = true
vim.opt.scrolloff = 5
vim.opt.shada = { '!', "'100", '<100', 'h', 'r/mnt', 'r/tmp', 's100' }
vim.opt.shiftwidth = 2
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
vim.opt.tabstop = 8
vim.opt.termguicolors = true
vim.opt.undofile = true
vim.opt.undolevels = 50
vim.opt.virtualedit = 'block'
vim.opt.wildignorecase = true

vim.api.nvim_set_keymap('c', 'ww', "w !sudo tee % > /dev/null", { noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>fmt', '<Cmd>lua vim.lsp.buf.formatting()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>n', ":noh<CR>", { noremap = true, silent = true })

vim.cmd([[
  autocmd FileType json,nix setlocal shiftwidth=2 softtabstop=2 tabstop=2
  autocmd FileType norg setlocal shiftwidth=2 tabstop=4
]])
