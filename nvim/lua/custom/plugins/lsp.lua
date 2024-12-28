return {
  "neovim/nvim-lspconfig",
  dependencies = { 'saghen/blink.cmp' },
  config = function()
    local capabilities = require("blink.cmp").get_lsp_capabilities()
    local lspconfig = require("lspconfig")

    -- setup for html
    lspconfig.html.setup({

      capabilities = capabilities,

      filetypes = { "html", "templ", "elixir" },

      init_options = {
        configurationSection = { "html", "css", "javascript", "elixir", "eelixir", "heex", "surface" },
        embeddedLanguages = {
          css = true,
          javascript = true,
          elixir = true,
          eelixir = true,
          heex = true,
        },
        provideFormatter = true,
      },
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
