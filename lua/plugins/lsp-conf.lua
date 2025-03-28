return {
    {
        'williamboman/mason.nvim',
        lazy = false,
        config = true,
    },

    -- Autocompletion
    {
        'hrsh7th/nvim-cmp',
        event = 'InsertEnter',
        config = function()
            local cmp = require('cmp')
            require('luasnip.loaders.from_vscode').lazy_load()

            cmp.setup({
                sources = {
                    { name = 'nvim_lsp' },
                    { name = 'luasnip' },
                    { name = 'buffer' }
                },
                mapping = cmp.mapping.preset.insert({
                    -- Accept on enter
                    ['<CR>']    = cmp.mapping.confirm({ select = false }),

                    -- trigger completion menu
                    ['<C-Space>'] = cmp.mapping.complete(),

                    -- Simple tab complete
                    ['<Tab>']   = cmp.mapping(function(fallback)
                        local col = vim.fn.col('.') - 1

                        if cmp.visible() then
                            cmp.select_next_item({ behavior = 'select' })
                        elseif col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
                            fallback()
                        else
                            cmp.complete()
                        end
                    end, { 'i', 's' }),

                    -- Go to previous item
                    ['<S-Tab>'] = cmp.mapping.select_prev_item({ behavior = 'select' }),
                    ['<C-u>']   = cmp.mapping.scroll_docs(-4),
                    ['<C-d>']   = cmp.mapping.scroll_docs(4),

                    -- jump to the next snippet placeholder
                    ['<C-f>'] = cmp.mapping(function(fallback)
                        local luasnip = require('luasnip')
                        if luasnip.locally_jumpable(1) then
                            luasnip.jump(1)
                        else
                            fallback()
                        end
                    end, {'i', 's'}),

                    -- jump to the previous snippet placeholder
                    ['<C-b>'] = cmp.mapping(function(fallback)
                        local luasnip = require('luasnip')
                        if luasnip.locally_jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end, {'i', 's'}),
                }),
                snippet = {
                    expand = function(args)
                        require('luasnip').lsp_expand(args.body)
                    end,
                },
            })
        end
    },
    -- LSP
    {
        'neovim/nvim-lspconfig',
        cmd = { 'LspInfo', 'LspInstall', 'LspStart' },
        event = { 'BufReadPre', 'BufNewFile' },
        dependencies = {
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'williamboman/mason.nvim' },
            { 'williamboman/mason-lspconfig.nvim' },
        },
        init = function()
            -- reserve space in the gutter
            vim.opt.signcolumn = "yes"
        end,
        config = function()
            local lsp_defaults = require('lspconfig').util.default_config

            lsp_defaults.capabilities = vim.tbl_deep_extend(
                'force',
                lsp_defaults.capabilities,
                require('cmp_nvim_lsp').default_capabilities()
            )

            -- LspAttach is where you enable features that only work
            -- if there is a language server active in the file
            vim.api.nvim_create_autocmd('LspAttach', {
                desc = 'LSP actions',
                callback = function(event)
                    local opts = { buffer = event.buf }

                    vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
                    vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
                    vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
                    vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
                    vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
                    vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
                    vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
                    vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
                    vim.keymap.set({ 'n', 'x' }, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
                    vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
                end,
            })

            require('mason-lspconfig').setup({
                ensure_installed = { "clangd", "lua_ls", "ts_ls", "rust_analyzer", "lua_ls" },
                handlers = {
                    function(server_name)
                        require('lspconfig')[server_name].setup({})
                    end,

                    lua_ls = function()
                        require('lspconfig').lua_ls.setup({
                            settings = {
                                Lua = {
                                    telemetry = {
                                        enable = false
                                    },
                                },
                            },
                            on_init = function(client)
                                local join = vim.fs.joinpath
                                local path = client.workspace_folders[1].name

                                -- Don't do anything if there is project local config
                                if vim.uv.fs_stat(join(path, '.luarc.json'))
                                    or vim.uv.fs_stat(join(path, '.luarc.jsonc'))
                                then
                                    return
                                end

                                -- Apply neovim specific settings
                                local runtime_path = vim.split(package.path, ';')
                                table.insert(runtime_path, join('lua', '?.lua'))
                                table.insert(runtime_path, join('lua', '?', 'init.lua'))

                                local nvim_settings = {
                                    runtime = {
                                        -- Tell the language server which version of Lua you're using
                                        version = 'LuaJIT',
                                        path = runtime_path
                                    },
                                    diagnostics = {
                                        -- Get the language server to recognize the `vim` global
                                        globals = { 'vim', }
                                    },
                                    workspace = {
                                        checkThirdParty = false,
                                        library = {
                                            -- Make the server aware of Neovim runtime files
                                            vim.env.VIMRUNTIME,
                                            vim.fn.stdpath('config'),
                                            "${3rd}/luv/library",
                                            unpack(vim.api.nvim_get_runtime_file('',true))
                                        },
                                    },
                                }

                                client.config.settings.Lua = vim.tbl_deep_extend(
                                    'force',
                                    client.config.settings.Lua,
                                    nvim_settings
                                )
                            end,
                        })
                    end,

                    volar = function()
                        require('lspconfig').volar.setup{}
                    end,

                    ts_ls = function()
                        local vue_typescript_plugin = require('mason-registry')
                            .get_package('vue-language-server')
                            :get_install_path()
                        .. '/node_modules/@vue/language-server'
                        .. '/node_modules/@vue/typescript-plugin'

                        require('lspconfig').ts_ls.setup({
                            init_options = {
                                plugins = {
                                    {
                                        name = "@vue/typescript-plugin",
                                        location = vue_typescript_plugin,
                                        languages = { 'javascript', 'typescript', 'vue' }
                                    },
                                }
                            },
                            filetypes = {
                                'javascript',
                                'javascriptreact',
                                'javascript.jsx',
                                'typescript',
                                'typescriptreact',
                                'typescript.tsx',
                                'vue',
                            },
                        })
                    end,
                    clangd = function()
                        require('lspconfig').clangd.setup {}
                    end
                }
            })
        end
    }
}
