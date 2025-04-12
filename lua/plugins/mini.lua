return {
  {
    'echasnovski/mini.nvim',
    version = false,
    config = function ()
      local icons = require 'mini.icons'
      icons.setup {}

      local surround = require 'mini.surround'
      surround.setup {}

      local pairs = require 'mini.pairs'
      pairs.setup {}

      local move = require 'mini.move'
      move.setup {}
    end
  }
}
