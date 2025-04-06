local map = vim.keymap.set

-- General remaps neovim --
map("n", "<leader>pv", vim.cmd.Ex)
map("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Window shortcuts
map('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
map('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
map('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
map('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Scroll with centering
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-U>zz")

-- Center screen while searching
map("n", "n", "nzz")
map("n", "N", "Nzz")
