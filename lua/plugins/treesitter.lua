return {
    'nvim-treesitter/nvim-treesitter',
    cmd = {"TSUpdate"},
    config = function()
        require('nvim-treesitter').setup({
            ensure_installed = {
                "c",
                "lua",
                "vim",
                "vimdoc",
                "query",
                "javascript",
                "typescript",
                "vue",
                "rust" },
            sync_install = false,
            auto_install = true,
            highlight = { enable = true},
            indent = { enable = true }
        }
)
    end
}

