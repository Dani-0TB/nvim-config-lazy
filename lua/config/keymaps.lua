local map = vim.keymap.set

-- General remaps neovim --
vim.g.mapleader = " "
map("n", "<leader>pv", vim.cmd.Ex)
map("n", "<leader>hl", ":noh<CR>")

map("n", "<C-d>", "25jzz")
map("n", "<C-u>", "25kzz")

map("n", "n", "nzz")
map("n", "N", "Nzz")

-- remaps file browser --
map("n", "<leader>fv", ":Telescope file_browser<CR>") -- open on project root
map("n", "<leader>fr", ":Telescope file_browser path=%:p:h select_buffer=true<CR>") -- open in buffer

-- remaps for fugitive
map("n", "<leader>gf", ":Git<CR>")

-- remaps for diagnostics
map('n', '<leader>do', ":lua vim.diagnostic.open_float()<CR>")
map('n', '<leader>dd', ":lua vim.diagnostic.setloclist()<CR>")
