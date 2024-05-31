-- System
vim.opt.backup = false
vim.opt.swapfile = false
vim.opt.syntax = ""
vim.opt.timeoutlen = 1500

-- indentation
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.smarttab = true
vim.opt.softtabstop = 4
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4

-- search
vim.opt.hlsearch = false
vim.opt.incsearch = true

--visual
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.wrap = false

-- Remaps
vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
