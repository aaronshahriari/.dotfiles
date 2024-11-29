require("obsidian").setup({
    workspaces = {
        {
            name = "Personal",
            path = "~/aaron_linux_vault/",
        },
        {
            name = "BrundageGroup",
            path = "~/work/BrundageGroup/",
        },
    },
    disable_frontmatter = true,
    ui = {
        enable = true,         -- set to false to disable all additional syntax features
        update_debounce = 200, -- update delay after a text change (in milliseconds)
        -- Define how various check-boxes are displayed
        checkboxes = {
            [" "] = { char = "", hl_group = "ObsidianTodo" },
            ["x"] = { char = "", hl_group = "ObsidianDone" },
            ["~"] = { char = "󰰰", hl_group = "ObsidianTilde" },
        },
    },
    open_app_foreground = false,
    open_notes_in = "vsplit",
    callbacks = {
        -- Runs anytime you enter the buffer for a note.
        enter_note = function(client, note)
            vim.cmd(":silent ObsidianOpen")
        end,
    },
})
vim.keymap.set("n", "gf", function()
    if require("obsidian").util.cursor_on_markdown_link() then
        return "<cmd>ObsidianFollowLink<CR>"
    else
        return "gf"
    end
end, { noremap = false, expr = true })
