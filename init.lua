-- Global setups
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.g.have_nerd_font = true

-- My options 
require "config.options"

-- My keymaps
require "config.keymaps"

-- Lazy.nvim bootstrap
require "config.lazy"
