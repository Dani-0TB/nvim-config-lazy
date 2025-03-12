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
    dependencies = {
      {'L3MON4D3/LuaSnip'},
    },
    config = function()
      -- And you can configure cmp even more, if you want to.
      local cmp = require('cmp')

      cmp.setup({
        mapping = cmp.mapping.preset.insert({
          ['<CR>']  = cmp.mapping.confirm({select= false}),
          ['<Tab']  = cmp.mapping.complete(),
          ['<C-u>'] = cmp.mapping.scroll_docs(-4),
          ['<C-d>'] = cmp.mapping.scroll_docs(4),
        }),
        snippet = {
          expand = function(args)
            vim.snippet.expand(args.body)
          end,
        },
      })
    end
  },
  -- LSP
  {
    'neovim/nvim-lspconfig',
    cmd = {'LspInfo', 'LspInstall', 'LspStart'},
    event = {'BufReadPre', 'BufNewFile'},
    dependencies = {
      {'hrsh7th/cmp-nvim-lsp'},
      {'williamboman/mason.nvim'},
      {'williamboman/mason-lspconfig.nvim'},
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
          local opts = {buffer = event.buf}

          vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
          vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
          vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
          vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
          vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
          vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
          vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
          vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
          vim.keymap.set({'n', 'x'}, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
          vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
        end,
      })

      require('mason-lspconfig').setup({
        ensure_installed = {"clangd","lua_ls", "ts_ls", "rust_analyzer", "lua_ls"},
        handlers = {
            -- this first function is the "default handler"
            -- it applies to every language server without a "custom handler"
              function(server_name)
                require('lspconfig')[server_name].setup({})
              end,

              lua_ls = function()
                require('lspconfig').lua_ls.setup({
                  settings = {
                    Lua = {
                      diagnostics = {
                        globals = {"vim"}
                      }
                    }
                  }
                })
              end,

              volar = function()
                require('lspconfig').volar.setup({})
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
                          languages = {'javascript', 'typescript', 'vue'}
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
          }
      })
    end
  }
}
