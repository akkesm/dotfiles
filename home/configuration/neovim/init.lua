vim.o.autochdir = true
vim.bo.autoindent = true
vim.o.autoread = true
vim.o.autowrite = true
vim.o.backup = true
vim.o.backupcopy = "yes"
vim.o.backupdir = "$XDG_DATA_HOME/nvim/backup"
vim.wo.breakindent = true
vim.o.browsedir = "buffer"
vim.bo.cindent = true
vim.o.clipboard = "unnamedplus"
vim.o.cmdheight = 2
vim.wo.colorcolumn = "70,80,100"
vim.o.completeopt = "menuone,noinsert,noselect"
vim.wo.concealcursor = "nc"
vim.wo.conceallevel = 0
vim.o.confirm = true
vim.bo.copyindent = true
vim.o.cpoptions = "aABcefFImnsW_"
vim.bo.expandtab = true
vim.bo.fileencoding = "utf-8"
vim.o.fileignorecase = false
vim.bo.formatoptions = vim.bo.formatoptions .. "nl"
vim.o.fsync = true
vim.o.guifont = "Iosevka Nerd Font 12"
vim.o.helplang = "it,en"
vim.o.history = 1000
vim.o.hlsearch = false
vim.o.ignorecase = true
vim.o.inccommand = "nosplit"
vim.o.incsearch = true
vim.o.joinspaces = true
vim.wo.linebreak = true
vim.wo.list = true
vim.o.listchars = "tab:»·,lead:·,trail:·,nbsp:⍽"
vim.o.mouse = "a"
vim.o.mousehide = false
vim.wo.number = true
vim.wo.numberwidth = 5
vim.o.pyxversion = 3
vim.o.ruler = true
vim.o.scrolloff = 5
vim.o.shada = "!,'100,<1000,h,r/mnt,s100"
vim.bo.shiftwidth = 2
vim.o.shortmess = "cfilnxtToO"
vim.o.showbreak = "+++ "
vim.o.showcmd = true
vim.o.showmode = true
vim.o.smartcase = true
vim.o.smarttab = true
vim.bo.softtabstop = 2
vim.o.splitbelow = true
vim.o.splitright = true
vim.bo.swapfile = true
vim.bo.tabstop = 8
vim.o.termguicolors = true
vim.bo.undofile = true
vim.o.virtualedit = "block"
vim.o.wildignorecase = true

vim.api.nvim_set_keymap('c', 'ww', "w !sudo tee % > /dev/null", { noremap = true })
vim.api.nvim_aet_keymap('n', '<Leader>n', ":noh<CR>", { noremap = true, silent = true })

-- local function make_backupdir()
--     if vim.fn.isdirectory(os.getenv("XDG_DATA_HOME/nvim/backup")) == 0 then
--         os.execute("mkdir -p $XDG_DATA_HOME/nvim/backup" )
--     end
-- end

make_backupdir()

-- "turn on hlsearch only while searching
vim.cmd([[
    augroup vimrc-incsearch-highlight
        autocmd!
        autocmd CmdlineEnter /,\? :vim.o.hlsearch
        autocmd CmdlineLeave /,\? :vim.o.nohlsearch
    augroup END
]])

vim.cmd("let base16colorspace=256")
vim.cmd("colorscheme base16-gruvbox-dark-hard")

-- airline and extensions
vim.cmd("let g:airline_theme='base16_gruvbox_dark_hard'")
vim.cmd("let g:bufferline_echo = 0")
vim.cmd("let g:bufferline_fname_mod = ':~'")
vim.cmd("let g:bufferline_pathshorten = 1")

-- CoC config
vim.cmd([["
    let g:coc_global_extensions = [
        \  'coc-sh'
        \, 'coc-cmake'
        \, 'coc-css'
        \, 'coc-diagnostic'
        \, 'coc-flutter'
        \, 'coc-fzf-preview'
        \, 'coc-gist'
        \, 'coc-git'
        \, 'coc-go'
        \, 'coc-html'
        \, 'coc-json'
        \, 'coc-perl'
        \, 'coc-pyright'
        \, 'coc-rust-analyzer'
        \, 'coc-solargraph'
        \, 'coc-texlab'
        \, 'coc-tsserver'
    \]
]])

-- hlslens config
vim.api.nvim_set_keymap('', 'n', "<Cmd>execute('normal! ' . v:count1 . 'n')<CR> <Cmd>lua require('hlslens').start()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('', 'N', "<Cmd>execute('normal! ' . v:count1 . 'N')<CR> <Cmd>lua require('hlslens').start()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('', '*', "<Plug>(asterisk-*)<Cmd>lua require('hlslens').start()<CR>")
vim.api.nvim_set_keymap('', '#', "<Plug>(asterisk-#)<Cmd>lua require('hlslens').start()<CR>")
vim.api.nvim_set_keymap('', 'g*', "<Plug>(asterisk-g*)<Cmd>lua require('hlslens').start()<CR>")
vim.api.nvim_set_keymap('', 'g#', "<Plug>(asterisk-g#)<Cmd>lua require('hlslens').start()<CR>")
vim.api.nvim_set_keymap('', 'z*', "<Plug>(asterisk-z*)<Cmd>lua require('hlslens').start()<CR>")
vim.api.nvim_set_keymap('', 'z#', "<Plug>(asterisk-z#)<Cmd>lua require('hlslens').start()<CR>")
vim.api.nvim_set_keymap('', 'gz*', "<Plug>(asterisk-gz*)<Cmd>lua require('hlslens').start()<CR>")
vim.api.nvim_set_keymap('', 'gz#', "<Plug>(asterisk-gz#)<Cmd>lua require('hlslens').start()<CR>")

-- indentline config
vim.cmd("let g:indentLine_char = '›'")
vim.cmd("let g:indentLine_first_char = g:indentLine_char")
-- let g:indentLine_char_list = ['|', '¦', '┆', '┊', '⸽']
vim.cmd("let g:indentLine_concealcursor = 'ivnc'")
vim.cmd("let g:indentLine_conceallevel = 2")
vim.cmd("let g:indentLine_defaultGroup = 'SpecialKey'")
vim.cmd("let g:indentLine_showFirstIndentLevel = 1")

-- latex live preview config
vim.cmd("let g:livepreview_engine = 'xelatex'")

-- lf config
vim.cmd("let g:lf_map_keys = 0")
vim.api.nvim_set_keymap('n', '<Leader>lf', ":Lf<CR>", { noremap = true })

-- telescope config
vim.api.nvim_set_keymap('n', '<Leader>ff', "lua require('telescope').extensions.fzf_writer.files()<CR>", { noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>fg', "lua require('telescope').extensions.fzf_writer.staged_grep()<CR>", { noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>fb', "lua require('telescope.builtin').buffers()<CR>", { noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>fh', "lua require('telescope.builtin').help_tags()<CR>", { noremap = true })
