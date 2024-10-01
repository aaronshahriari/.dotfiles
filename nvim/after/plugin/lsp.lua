local lsp_zero = require('lsp-zero')

lsp_zero.on_attach(function(client, bufnr)
    lsp_zero.default_keymaps({ buffer = bufnr })
end)

-- load nvim-lspconfig
local lspconfig = require('lspconfig')

-- setup for apex_ls
lspconfig.apex_ls.setup({
    apex_jar_path = vim.fn.expand("/home/ashahriari/apex-jorje-lsp.jar"),
    apex_enable_semantic_errors = false,
    apex_enable_completion_statistics = false,
    filetypes = { "apex", "apexcode" },
})

-- setup for lua
lspconfig.lua_ls.setup({})

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

vim.api.nvim_create_autocmd("BufWritePre", {
    buffer = buffer,
    callback = function()
        vim.lsp.buf.format { async = false }
    end
})
