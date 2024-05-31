return {
    'nvim-treesitter/nvim-treesitter',
    build = {":TSUpdate"},
    config = function()
        require('nvim-treesitter.configs').setup({
            ensure_installed = {
                "c",
                "lua",
                "vim",
                "vimdoc",
                "query",
                "javascript",
                "typescript",
                "vue",
                "rust",
                "html"},
            sync_install = false,
            auto_install = true,
            highlight = { enable = true},
            indent = { enable = true }
        })
    end
}

