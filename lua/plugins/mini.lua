return {
    {
        'echasnovski/mini.nvim',
        version = false,
        config = function ()
            local icons = require 'mini.icons'
            icons.setup {}

            local surround = require 'mini.surround'
            surround.setup {}
        end
    }
}
