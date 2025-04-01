local opt = vim.opt
-- system --
opt.backup = false
opt.swapfile = false
opt.syntax = ""
opt.timeoutlen = 1500

-- indentation --
opt.expandtab = true
opt.smartindent = true
opt.smarttab = true
opt.shiftround = true
opt.softtabstop = 4
opt.tabstop = 4
opt.shiftwidth = 4

-- search --
opt.incsearch = true

-- visual --
opt.number = true
opt.relativenumber = true
opt.scrolloff = 8
opt.signcolumn = "yes"
opt.wrap = true
opt.statusline = "%f"

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
map("n", "<leader>fB", ":Telescope file_browser<CR>") -- open on project root
map("n", "<leader>fb", ":Telescope file_browser path=%:p:h select_buffer=true<CR>") -- open in buffer

-- remaps for fugitive
map("n", "<leader>gf", ":Git<CR>")

-- remaps for diagnostics
map('n', '<leader>do', ":lua vim.diagnostic.open_float()<CR>")
map('n', '<leader>dd', ":lua vim.diagnostic.setloclist()<CR>")
