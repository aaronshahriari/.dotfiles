return {
  "nvim-tree/nvim-web-devicons",
  config = function()
    local nvim_web_devicons = require("nvim-web-devicons")
    nvim_web_devicons.setup({
      override = {
        soql = {
          icon = "",
          color = "#A8E03F",
          cterm_color = "65",
          name = "Soql",
        },
        apex = {
          icon = "󰢎",
          color = "#4290F5",
          cterm_color = "65",
          name = "Apex",
        },
      },
      color_icons = true,
    })
  end
}
