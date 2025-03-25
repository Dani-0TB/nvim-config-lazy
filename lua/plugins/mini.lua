return {
    {
        'echasnovski/mini.nvim',
        config = function ()
            local icons = require 'mini.icons'
            icons.setup()

            local pairs = require 'mini.pairs'
            pairs.setup()

            local surround = require 'mini.surround'
            surround.setup()

            local statusline = require 'mini.statusline'
            statusline.setup()
        end,
    }
}
