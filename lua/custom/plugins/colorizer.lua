return {
  "norcalli/nvim-colorizer.lua",
  config = function()
    local color = require("colorizer")
    color.setup({
      'lua',
      css = { rgb_fn = true, },
      html = { names = false, },
    })
  end
}
