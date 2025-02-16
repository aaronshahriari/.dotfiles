return {
  "akinsho/toggleterm.nvim",
  version = "*",
  config = function()
    local toggleterm = require("toggleterm")
    toggleterm.setup({
      open_mapping = [[<c-\>]],
      start_in_insert = false,
      persist_size = true,
      persist_mode = true,
      auto_scroll = false,
    })
    vim.keymap.set("n", "<C-p>", "<Cmd>ToggleTerm size=90 direction=vertical name=vertical<CR>")
    vim.keymap.set("n", "<C-g>", "<Cmd>ToggleTerm size=15 direction=horizontal name=horizontal<CR>")
  end
}
