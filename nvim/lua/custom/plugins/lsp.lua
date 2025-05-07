return {
  "neovim/nvim-lspconfig",
  dependencies = { 'saghen/blink.cmp' },
  config = function()
    local lspconfig = require("lspconfig")
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    -- local default_capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
    local default_capabilities = require('blink.cmp').get_lsp_capabilities(capabilities)

    -- Default handlers for LSP
    local default_handlers = {
      ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "single" }),
      ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "single" }),
    }

    -- ELIXIR
    lspconfig.elixirls.setup({
      handlers = default_handlers,
      capabilities = capabilities,
      cmd = { "elixir-ls" },
      filetypes = { "exs", "elixir", "eelixir", "heex", "surface" },
      root_dir = lspconfig.util.root_pattern("mix.exs"),
    })

    -- PHP
    lspconfig.intelephense.setup({
      handlers = default_handlers,
      capabilities = default_capabilities,
    })

    -- PYTHON
    lspconfig.pylsp.setup({
      handlers = default_handlers,
      capabilities = default_capabilities,
    })

    -- ZIG
    lspconfig.zls.setup({
      handlers = default_handlers,
      capabilities = default_capabilities,
      settings = {
        zls = {
          enable_argument_placeholders = false,
        },
      },
    })
    -- don't show parse errors in a separate window
    vim.g.zig_fmt_parse_errors = 0
    -- disable format-on-save
    vim.g.zig_fmt_autosave = 0

    -- BASH
    lspconfig.bashls.setup({})

    -- TAILWINDCSS
    vim.lsp.config('tailwindcss', {
      cmd = { 'tailwindcss-language-server', '--stdio' },
      handlers = default_handlers,
      capabilities = default_capabilities,
      root_dir = vim.fs.dirname(
        vim.fs.find({ "tailwind.config.js", "tailwind.config.ts", "postcss.config.js", "package.json", ".git" }, {
          upward = true,
          path = vim.api.nvim_buf_get_name(0),
        })[1]
      ),
      settings = {
        tailwindCSS = {
          includeLanguages = {
            eelixir = "html-eex",
            elixir = "html-eex",
            heex = "html-eex",
          },
          experimental = {
            classRegex = {
              'class[:]\\s*"([^"]*)"',
            },
          },
        },
      },
    })
    vim.lsp.enable('tailwindcss')

    -- HTML
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

    -- LUA
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

    -- NIX
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

    -- MD
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
