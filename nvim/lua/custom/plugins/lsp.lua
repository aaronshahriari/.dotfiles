return {
  "neovim/nvim-lspconfig",
  dependencies = { 'saghen/blink.cmp' },
  config = function()
    local capabilities = require("blink.cmp").get_lsp_capabilities()
    local lspconfig = require("lspconfig")
    local _border = "single"

    -- Add the border on hover and on signature help popup window
    local handlers = {
      ['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, { border = _border }),
      ['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = _border }),
    }

    -- Add border to the diagnostic popup window
    vim.diagnostic.config({
      float = { border = _border },
    })

    -- setup for lua
    lspconfig.lua_ls.setup({
      capabilities = capabilities,
      handlers = handlers,
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

    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = buffer,
      callback = function()
        vim.lsp.buf.format { async = false }
      end
    })
  end
}
