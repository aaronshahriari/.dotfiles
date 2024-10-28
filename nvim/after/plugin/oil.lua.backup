require("oil").setup({
    default_file_explorer = true,
    columns = {
        "icon",
    },
    view_options = {
        show_hidden = true,
    },
    keymaps = {
        ["<CR>"] = "actions.select",
        ["<C-v>"] = "actions.select_vsplit",
        ["<C-x>"] = "actions.select_split",
        ["<C-t>"] = "actions.select_tab",
        ["<C-p>"] = "actions.preview",
        ["<C-r>"] = "actions.refresh",
        ["-"] = "actions.parent",
    },
    use_default_keymaps = false,
    float = {
        -- Padding around the floating window
        padding = 2,
        max_width = 70,
        max_height = 30,
        border = "single",
        win_options = {
            winblend = 0,
        },
    },
      skip_confirm_for_simple_edits = true,
      prompt_save_on_select_new_entry = false,
})

-- Open parent directory in floating window
vim.keymap.set("n", "<space>-", require("oil").toggle_float)
vim.keymap.set("n", "<leader>pv", require("oil").open)
