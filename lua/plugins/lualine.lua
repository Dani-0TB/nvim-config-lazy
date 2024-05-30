local options = {
    theme = "gruvbox"
}

return {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function(options)
        require("lualine").setup(options)     
    end
}
