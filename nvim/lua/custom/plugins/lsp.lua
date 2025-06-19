return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
  },
  config = function()
    local lspconfig = require("lspconfig")
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    -- local default_capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

    -- Default handlers for LSP
    local default_handlers = {
      ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "single" }),
      ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "single" }),
    }

    -- SETUP FOR APEX
    -- vim.lsp.config.apex_ls = {
    --   cmd = {
    --     "java",
    --     "-jar",
    --     vim.fn.expand('$HOME/lsp/apex-jorje-lsp.jar'),
    --   },
    --   root_markers = { 'sfdx-project.json' },
    --   filetypes = { 'apex' },
    -- }
    -- vim.lsp.enable({ 'apex_ls' })

    -- vim.lsp.config.sqls = {
    --   filetypes = { "sql", "mysql", "soql" },
    -- }
    -- vim.lsp.enable("sqls")


    lspconfig.apex_ls.setup({
      cmd = {
        "java",
        "-jar",
        vim.fn.expand('$HOME/lsp/apex-jorje-lsp.jar'),
      },
      filetypes = { 'apex' },
      apex_enable_semantic_errors = false,
      apex_enable_completion_statistics = false,
    })

    -- SETUP FOR LUA
    lspconfig.lua_ls.setup({
      handlers = default_handlers,
      capabilities = default_capabilities,
      settings = {
        Lua = {
          diagnostics = {
            globals = { 'vim' }
          }
        }
      }
    })

    -- SETUP FOR MD
    lspconfig.markdown_oxide.setup({})

    require("mason").setup()
    local ensure_installed = {
      "stylua",
      "lua_ls",
    }
    require("mason-tool-installer").setup { ensure_installed = ensure_installed }

    local allowed_filetypes = { "lua", "nix", "sh" }
    vim.api.nvim_create_autocmd("BufWritePre", {
      callback = function()
        if vim.tbl_contains(allowed_filetypes, vim.bo.filetype) then
          vim.lsp.buf.format { async = false }
        end
      end
    })
  end
}
