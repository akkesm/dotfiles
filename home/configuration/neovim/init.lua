vim.opt.autowrite = true
vim.opt.backup = true
vim.opt.backupcopy = 'yes'
vim.opt.backupdir = "$XDG_DATA_HOME/nvim/backup"
vim.opt_local.breakindent = true
vim.opt.browsedir = 'current'
vim.opt_local.cindent = true
vim.opt.clipboard = 'unnamedplus'
vim.opt.cmdheight = 2
vim.opt_local.colorcolumn = { '70', '80', '100' }
vim.opt.completeopt = { 'menuone', 'noinsert', 'noselect' }
vim.opt_local.concealcursor = 'c'
vim.opt_local.conceallevel = 2
vim.opt.confirm = true
vim.opt_local.copyindent = true
vim.opt.cpoptions:append({ 'f', 'I', 'm', 'n', 'W' })
vim.opt_local.expandtab = true
vim.opt_local.fileencoding = 'utf-8'
vim.opt.fileignorecase = false
vim.opt_local.formatoptions:append({ 'n', 'l' })
vim.opt.fsync = true
vim.opt.guifont = 'Iosevka Nerd Font 12'
vim.opt.helplang = { 'it', 'en' }
vim.opt.history = 1000
vim.opt.hlsearch = false
vim.opt.ignorecase = true
vim.opt.inccommand = 'nosplit'
vim.opt.incsearch = true
vim.opt.joinspaces = true
vim.opt_local.linebreak = true
vim.opt_local.list = true
vim.opt.listchars = { tab = '»·', lead = '·', trail = '·', nbsp = '⍽' }
vim.opt.mouse = 'a'
vim.opt.mousehide = false
vim.opt_local.number = true
vim.opt_local.numberwidth = 5
vim.opt.pyxversion = 3
vim.opt_local.relativenumber = true;
vim.opt.ruler = true
vim.opt.scrolloff = 5
vim.opt.shada = { '!', "'100", '<100', 'h', 'r/mnt', 'r/tmp', 's100' }
vim.opt_local.shiftwidth = 2
vim.opt.shortmess:append({ 'I', 'c' })
vim.opt.showbreak = '+++ '
vim.opt.showcmd = true
vim.opt.showmode = true
vim.opt.smartcase = true
vim.opt.smarttab = true
vim.opt_local.softtabstop = 2
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt_local.swapfile = true
vim.opt_local.tabstop = 8
vim.opt.termguicolors = true
vim.opt_local.undofile = true
vim.opt.undolevels = 50
vim.opt.virtualedit = 'block'
vim.opt.wildignorecase = true

vim.api.nvim_set_keymap('c', 'ww', "w !sudo tee % > /dev/null", { noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>fmt', '<Cmd>lua vim.lsp.buf.formatting()<CR>', { noremap = true, silent = true })
vim.api.nvim_aet_keymap('n', '<Leader>n', ":noh<CR>", { noremap = true, silent = true })

vim.cmd([[
  autocmd FileType json,nix setlocal shiftwidth=2 softtabstop=2 tabstop=2
  autocmd FileType norg setlocal shiftwidth=2 tabstop=4
]])
