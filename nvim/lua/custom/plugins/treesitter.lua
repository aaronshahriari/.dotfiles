return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    local tree = require("nvim-treesitter.configs")
    tree.setup {
      ensure_installed = { "php", "html", "markdown_inline", "java", "python", "javascript", "c", "lua", "vim", "vimdoc", "query" },
      sync_install = false,
      auto_install = false,
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
      indent = {
        enable = true,
      }
    }
  end
}
