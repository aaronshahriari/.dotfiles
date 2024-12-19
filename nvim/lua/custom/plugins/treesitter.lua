return {
  "nvim-treesitter/nvim-treesitter",
  tag = "v0.9.2",
  build = ":TSUpdate",
  config = function()
    local tree = require("nvim-treesitter.configs")
    tree.setup {
      ensure_installed = { "markdown_inline", "java", "python", "javascript", "c", "lua", "vim", "vimdoc", "query" },
      sync_install = false,
      auto_install = true,
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
    }
  end
}
