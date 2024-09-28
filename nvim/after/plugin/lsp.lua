local lsp_zero = require('lsp-zero')

lsp_zero.on_attach(function(client, bufnr)
    -- see :help lsp-zero-keybindings
    -- to learn the available actions
    lsp_zero.default_keymaps({buffer = bufnr})
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
--
-- setup for nix
lspconfig.nix.setup({
    cmd = { "nil" },
    filetypes = { "nix" },
})
