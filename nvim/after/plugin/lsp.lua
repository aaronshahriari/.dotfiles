-- load nvim-lspconfig
local lspconfig = require('lspconfig')

-- setup for lua
lspconfig.lua_ls.setup({
    settings = {
        Lua = {
            diagnostics = {
                globals = { 'vim' }
            }
        }
    }
})

-- setup for nix
lspconfig.nil_ls.setup({
    settings = {
        ['nil'] = {
            formatting = {
                command = { "nixfmt" },
            },
        },
    },
})

-- setup for md
lspconfig.markdown_oxide.setup({})
