return {
  "neovim/nvim-lspconfig",
  config = function()
    local lspconfig = require("lspconfig")
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    local default_capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

    -- setup for tailwindcss
    lspconfig.tailwindcss.setup({
      capabilities = default_capabilities,
      init_options = {
        userLanguages = {
          elixir = "html-eex",
          eelixir = "html-eex",
          heex = "html-eex",
        },
      },
      settings = {
        tailwindCSS = {
          experimental = {
            classRegex = {
              'class[:]\\s*"([^"]*)"',
            },
          },
        },
      }
    })

    -- setup for html
    lspconfig.html.setup({
      capabilities = default_capabilities,
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
      capabilities = default_capabilities,
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
      capabilities = default_capabilities,
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
