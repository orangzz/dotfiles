vim.opt.smartcase = true
vim.opt.showmode = false
vim.opt.swapfile = false
vim.opt.undodir = string.format("%s/undodir", vim.fn.stdpath("cache"))
vim.opt.undofile = true
vim.opt.incsearch = true
vim.opt.hidden = true
vim.opt.completeopt = { "menuone", "noinsert", "noselect" }
vim.opt.shortmess:append("c")
vim.opt.smartindent = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.scrolloff = 7
vim.opt.expandtab = true
vim.opt.foldlevelstart = 99
vim.opt.number = true -- display line numbers
vim.opt.relativenumber = true -- display relative line numbers
vim.opt.signcolumn = "yes"
vim.opt.wrap = true
vim.opt.wildignorecase = true
vim.opt.showmatch = true
vim.opt.ignorecase = true
vim.opt.laststatus = 3


vim.opt.hlsearch = true
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10
-- Preview substitutions live, as you type!
vim.opt.inccommand = "split"
-- if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
-- instead raise a dialog asking if you wish to save the current file(s)
-- See `:help 'confirm'`
vim.opt.confirm = true
