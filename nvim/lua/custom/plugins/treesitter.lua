return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    local tree = require("nvim-treesitter.configs")
    tree.setup {
      ensure_installed = {
        "elixir",
        "php",
        "html",
        "java",
        "python",
        "javascript",
        "c",
        "lua",
        "vim",
        "vimdoc",
        "query",
        "eex",
        "elixir",
        "erlang",
        "heex",
        "html",
        "surface",
      },
      sync_install = false,
      auto_install = false,
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
        disable = { "markdown", "markdown_inline" },
      },
      indent = {
        enable = true,
        disable = { "html" },
      }
    }
  end
}
