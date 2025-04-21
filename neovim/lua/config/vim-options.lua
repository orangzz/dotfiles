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
