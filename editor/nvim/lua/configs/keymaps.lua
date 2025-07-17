local map = vim.keymap.set

vim.g.mapleader = " "
vim.g.maplocalleader = "-"


local M = {}

M.init = function()
    map('n', '<leader><spae>', function()
        require('telescope.builtin').find_files()
    end, { slient = true, desc = 'Find files' })
    map('n', '<leader>f', function()
        require('telescope.builtin').live_grep()
    end, { slient = true, desc = 'live grep' })
    map('n', '<leader>b', function()
        require('telescope.builtin').buffers()
    end, { slient = true, desc = 'Buffers' })

    map('n', '-', '<CMD>Oil<CR>', { desc = 'Open parent directory' })

    map('n', '<leader>,', ':noh<CR>', { desc = 'Clear search highligh' })

    map('n', '<leader>g', '<cmd>Neogit<CR>', { desc = 'Neogit' })

    map('n', '<C-h>', ':bp<CR>', { desc = 'Go to previous buffer' })

    map('n', '<C-l>', ':bn<CR>', { desc = 'Go to next buffer' })
end

return M
