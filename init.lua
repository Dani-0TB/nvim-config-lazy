-- Options --

-- System
vim.opt.backup = false
vim.opt.swapfile = false
vim.opt.syntax = ""
vim.opt.timeoutlen = 1500

-- indentation
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.cindent = true
vim.opt.smarttab = true
vim.opt.softtabstop = 4
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4

-- search
vim.opt.hlsearch = false
vim.opt.incsearch = true

--visual
vim.opt.colorcolumn = "81"
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.scrolloff = 8
vim.opt.signcolumn = "auto:1"
vim.opt.wrap = false

-- Remaps
vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- Package Manager
-- lazy.nvim

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
    { "ellisonleao/gruvbox.nvim", priority = 1000 , config = true },
    {
    'nvim-telescope/telescope.nvim', tag = '0.1.6',
      dependencies = { 'nvim-lua/plenary.nvim' }
    },
    {'nvim-treesitter/nvim-treesitter', build = ":TSUpdate", cmd = "TSUpdate" }
}

require("lazy").setup(plugins)

-- Colorscheme

require("gruvbox").setup({
    contrast = "hard"
})

vim.cmd.colorscheme("gruvbox")

-- telescope

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
vim.keymap.set('n', '<C-p>', builtin.git_files, {})
vim.keymap.set('n', '<leader>ps', function()
   builtin.grep_string({search = vim.fn.input("Grep > ")}) 
end)

-- Transparency and colorscheme function

function SetColors(color)
    color = color or "gruvbox"
    vim.cmd.colorscheme(color)
    vim.api.nvim_set_hl(0, "Normal", {bg = "none"})
    vim.api.nvim_set_hl(0, "NormalFloat", {bg = "none"})
end

SetColors()

require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all" (the five listed parsers should always be installed)
  ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "javascript", "typescript", "rust" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,


  highlight = {
    enable = true,
 }
}
