return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    opts = {
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
        }
      end
    },
  },
}
