return {
  "neovim/nvim-lspconfig",
  config = function()
    local lspconfig = require("lspconfig")
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    local default_capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

    -- Default handlers for LSP
    local default_handlers = {
      ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "single" }),
      ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "single" }),
    }

    -- SETUP FOR PYTHON
    lspconfig.pylsp.setup({
      handlers = default_handlers,
      capabilities = default_capabilities,
    })

    -- SETUP FOR ZIG
    lspconfig.zls.setup({
      handlers = default_handlers,
      capabilities = default_capabilities,
      enable_argument_placeholders = false,
    })
    -- don't show parse errors in a separate window
    vim.g.zig_fmt_parse_errors = 0
    -- disable format-on-save
    vim.g.zig_fmt_autosave = 0

    -- SETUP FOR BASH
    lspconfig.bashls.setup({})

    -- SETUP FOR TAILWINDCSS
    lspconfig.tailwindcss.setup({
      handlers = default_handlers,
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

    -- SETUP FOR HTML
    lspconfig.html.setup({
      handlers = default_handlers,
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

    -- SETUP FOR NIX
    lspconfig.nil_ls.setup({
      handlers = default_handlers,
      capabilities = default_capabilities,
      settings = {
        ['nil'] = {
          formatting = {
            command = { "nixfmt" },
          },
        },
      },
    })

    -- SETUP FOR MD
    lspconfig.markdown_oxide.setup({})

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
