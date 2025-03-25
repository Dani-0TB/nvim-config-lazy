-- system
vim.opt.backup = false
vim.opt.swapfile = false
vim.opt.syntax = ""
vim.opt.timeoutlen = 1500

-- indentation
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.smarttab = true
vim.opt.shiftround = true
vim.opt.softtabstop = 4
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4

-- search
vim.opt.hlsearch = false
vim.opt.incsearch = true

-- visual --
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.wrap = true

-- remaps neovim --
vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

vim.keymap.set("n", "<C-d>", "25jzz")
vim.keymap.set("n", "<C-u>", "25kzz")

vim.keymap.set("n", "n", "nzz")
vim.keymap.set("n", "N", "Nzz")

-- remaps file browser
vim.keymap.set("n", "<leader>fB", ":Telescope file_browser<CR>")
vim.keymap.set("n", "<leader>fb", ":Telescope file_browser path=%:p:h select_buffer=true<CR>")

vim.keymap.set("n", "<leader>gi", ":Git<CR>")
