return {
  'stevearc/conform.nvim',
  opts = {},
  config = function()
    local conform = require("conform")
    conform.setup {
      formatters_by_ft = {
        lua = { "stylua" },
        go = { "gofmt" },
        nix = { "nixfmt" },
        -- sql = { "sql_formatter" },
        zig = { "zigfmt" },
      },
    }

    conform.formatters.injected = {
      options = {
        ignore_errors = false,
        lang_to_formatters = {
          sql = { "sleek" },
        },
      },
    }

    vim.api.nvim_create_autocmd("BufWritePre", {
      group = vim.api.nvim_create_augroup("ConformAutoFormat", { clear = true }),
      callback = function(args)
        require("conform").format({
          bufnr = args.buf,
          lsp_fallback = true,
          quiet = true,
        })
      end,
    })
  end
}
