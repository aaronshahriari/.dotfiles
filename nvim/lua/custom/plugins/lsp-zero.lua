return {
  "VonHeikemen/lsp-zero.nvim",
  branch = "v4.x",
  dependencies = {},
  config = function()
    local lsp_zero = require("lsp-zero")

    lsp_zero.on_attach(function(client, bufnr)
      lsp_zero.default_keymaps({ buffer = bufnr })
    end)
  end
}
