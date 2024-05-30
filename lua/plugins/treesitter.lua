opts = {
  ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "javascript", "typescript", "rust" },
  sync_install = false,
  auto_install = true,
  highlight = { enable = true},
  indent = { enable = true }
}

return {
    'nvim-treesitter/nvim-treesitter',
    build = ":TSUpdate",
    config = function(opts) end
}

