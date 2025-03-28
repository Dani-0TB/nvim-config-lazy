return {
    {
        'echasnovski/mini.nvim',
        version = false,
        config = function ()
            local icons = require 'mini.icons'
            icons.setup {}

            local pairs = require 'mini.pairs'
            pairs.setup {}

            local surround = require 'mini.surround'
            surround.setup {}
        end
    }
}
