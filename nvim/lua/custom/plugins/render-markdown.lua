return {
  "MeanderingProgrammer/render-markdown.nvim",
  dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
  ---@module "render-markdown"
  ---@type render.md.UserConfig
  config = function()
    local render = require("render-markdown")
    render.setup({
      heading = { enabled = false, },
      paragraph = { enabled = false, },
      code = { enabled = false, },
      dash = { enabled = false, },
      bullet = { enabled = false, },
      quote = { enabled = false, },
      pipe_table = { enabled = false, },
      link = { enabled = false, },
      sign = { enabled = false, },
      indent = { enabled = false, },
      checkbox = {
        enabled = true,
        position = 'inline',
        unchecked = {
          icon = ' ',
          -- highlight for the unchecked icon
          -- highlight = 'RenderMarkdownUnchecked',
          -- highlight for item associated with unchecked checkbox
          scope_highlight = nil,
        },
        checked = {
          icon = ' ',
          -- highlight for the checked icon
          -- highlight = 'RenderMarkdownChecked',
          -- highlight for item associated with checked checkbox
          scope_highlight = nil,
        },
        -- custom = {
        --   todo = {
        --     raw = '[-]',
        --     rendered = '󰥔 ',
        --     highlight = 'RenderMarkdownTodo',
        --     scope_highlight = nil
        --   },
        -- },
      },
    })
  end
}
