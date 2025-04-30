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
    local util = require("lspconfig.util")

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
              'class[:]\\s*"([^"]*)"', -- if you use Tailwind like: class: "..."
            },
          },
        },
      },
      filetypes = {
        "html",
        "heex",
        "eelixir",
      },
      root_dir = function(fname)
        return util.root_pattern("assets/tailwind.config.js", "tailwind.config.ts")(fname)
            or util.find_git_ancestor(fname)
      end,
    })

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
