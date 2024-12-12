require("trouble").setup({
    focus = true, -- Focus the window when opened
})
vim.keymap.set("n", "<C-x>", "<cmd>Trouble diagnostics toggle<cr>")
