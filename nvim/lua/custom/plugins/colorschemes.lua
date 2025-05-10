return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    opts = {
      integrations = { blink_cmp = true },
      term_colors = true,
      transparent_background = false,
      color_overrides = {
        mocha = {
          base = "#000000",
          mantle = "#000000",
          crust = "#000000",
        },
      },
      custom_highlights = function(colors)
        return {
          WinSeparator = { fg = colors.flamingo, bg = colors.base },
          TermCursorNC = { fg = "#000000", bg = "#000000" },
          CurSearch = { fg = "#000000", bg = "#F6FF00" },
          BlinkCmpSignatureHelpActiveParameter = { fg = "#ffffff", bg = colors.base },
        }
      end
    },
  },
}
