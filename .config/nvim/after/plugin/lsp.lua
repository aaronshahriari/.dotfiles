local lsp_zero = require('lsp-zero')

lsp_zero.on_attach(function(client, bufnr)
    -- see :help lsp-zero-keybindings
    -- to learn the available actions
    lsp_zero.default_keymaps({buffer = bufnr})
end)

require('mason').setup({})
require('mason-lspconfig').setup({
    ensure_installed = {},
    handlers = {
        lsp_zero.default_setup,
        lua_ls = function()
            local lua_opts = lsp_zero.nvim_lua_ls()
            require('lspconfig').lua_ls.setup(lua_opts)
        end,
        apex_ls = function()
            require('lspconfig').apex_ls.setup ({
                apex_jar_path = vim.fn.expand("/home/ashahriari/apex-jorje-lsp.jar"), -- change according to current system
                apex_enable_semantic_errors = false,
                apex_enable_completion_statistics = false,
                filetypes = {
                    "apex",
                    "apexcode",
                },
            })
        end,
    },
})
