return {
    {
        'nvim-telescope/telescope.nvim', tag = '0.1.8',
        dependencies = {
            'nvim-lua/plenary.nvim',
            {
                'nvim-telescope/telescope-fzf-native.nvim',
                build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release'
            }
        },
        config = function()
            require('telescope').setup {
                extensions = {
                    fzf = {}
                }
            }

            require('telescope').load_extension('fzf')

            local builtin = require('telescope.builtin')
            vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
            vim.keymap.set('n', '<C-p>', builtin.git_files, {})
            vim.keymap.set('n', '<leader>fs', function()
                builtin.grep_string({search = vim.fn.input("Grep > ")})
            end)
            vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags [F]ind [H]elp' })
            vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep [F]ile [Grep]' })
            vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers [F]ind [B]uffer' })
        end
    },
    {
        "nvim-telescope/telescope-file-browser.nvim",
        dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" }
    },
}
