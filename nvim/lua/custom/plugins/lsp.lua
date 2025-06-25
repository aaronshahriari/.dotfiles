return {
  "neovim/nvim-lspconfig",
  dependencies = {
    'saghen/blink.cmp',
    { "j-hui/fidget.nvim", opts = {} },
  },
  config = function()
    local lspconfig = require("lspconfig")

    -- proper context for diagnostics
    vim.diagnostic.config({
      -- virtual_text = {
      --   prefix = '■ ', -- Could be '●', '▎', 'x', '■', , 
      -- },
      float = { border = "single" },
    })


    -- REMAPS
    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(e)
        local opts = { buffer = e.buf }
        local builtin = require "telescope.builtin"
        vim.keymap.set("n", "gr", builtin.lsp_references, opts)
        vim.keymap.set("n", "gD", function() vim.lsp.buf.declaration() end, opts)
        vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
        vim.keymap.set("n", "<leader>cr", function() vim.lsp.buf.rename() end, opts)
        vim.keymap.set('n', 'K', function() vim.lsp.buf.hover({ border = 'single' }) end, opts)
        vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
        vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
      end,
    })

    -- TYPST
    vim.lsp.enable('typst_lsp')

    -- GO
    vim.lsp.enable("gopls")

    -- SQL
    -- vim.lsp.enable("sqls")

    -- RUST
    vim.lsp.config('rust_analyzer', {
      settings = {
        ['rust-analyzer'] = {
          diagnostics = {
            enable = false,
          }
        }
      }
    })
    vim.lsp.enable('rust_analyzer')

    -- ELIXIR
    lspconfig.elixirls.setup({
      cmd = { "elixir-ls" },
      filetypes = { "exs", "elixir", "eelixir", "heex", "surface" },
      root_dir = lspconfig.util.root_pattern("mix.exs"),
    })

    -- PYTHON
    vim.lsp.enable('pylsp')

    -- TYPESCRIPT
    vim.lsp.enable('ts_ls')

    -- ZIG
    vim.lsp.config('zls', {
      on_attach = function(client, bufnr)
        client.server_capabilities.documentFormattingProvider = false
      end,
      settings = {
        zls = {
          enable_argument_placeholders = false,
        },
      }
    })
    vim.lsp.enable('zls')
    -- don't show parse errors in a separate window
    vim.g.zig_fmt_parse_errors = 0
    -- disable format-on-save
    vim.g.zig_fmt_autosave = 0

    -- BASH
    vim.lsp.enable('bashls')

    -- TAILWINDCSS
    vim.lsp.config('tailwindcss', {
      cmd = { 'tailwindcss-language-server', '--stdio' },
    })
    vim.lsp.enable('tailwindcss')

    -- HTMX
    vim.lsp.enable('htmx')

    -- HTML
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.completion.completionItem.snippetSupport = true
    vim.lsp.config('html', {
      capabilities = capabilities,
    })

    vim.lsp.enable('html')

    -- LUA
    vim.lsp.config('lua_ls', {
      settings = {
        ['Lua'] = {
          diagnostics = {
            globals = { 'vim' }
          }
        }
      }
    })
    vim.lsp.enable('lua_ls')

    -- NIX
    vim.lsp.config('nil_ls', {
      settings = {
        ['nil'] = {
          formatting = {
            command = { "nixfmt" },
          },
        },
      }
    })
    vim.lsp.enable('nil_ls')

    -- MD
    vim.lsp.enable('markdown_oxide')
  end
}
