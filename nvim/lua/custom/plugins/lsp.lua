return {
  "neovim/nvim-lspconfig",
  config = function()
    local lspconfig = require("lspconfig")

    -- setup for tailwindcss
    lspconfig.tailwindcss.setup({})

    -- setup for html
    lspconfig.html.setup({
      filetypes = { "html", "templ", "heex" },
      init_options = {
        configurationSection = { "html", "css", "javascript", "elixir", "eelixir", "heex", "surface" },
        embeddedLanguages = {
          css = true,
          javascript = true,
          elixir = true,
          eelixir = true,
          heex = true,
        },
        provideFormatter = false,
      },
    })

    -- setup for lua
    lspconfig.lua_ls.setup({
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
