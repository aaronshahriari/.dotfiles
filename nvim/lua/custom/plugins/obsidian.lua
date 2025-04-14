return {
  "epwalsh/obsidian.nvim",
  version = "*", -- recommended, use latest release instead of latest commit
  lazy = true,
  ft = "markdown",
  dependencies = {
    -- Required.
    "nvim-lua/plenary.nvim",
  },
  config = function()
    local obs = require("obsidian")
    obs.setup({
      workspaces = {
        {
          name = "Personal",
          path = "~/vault_personal/",
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
  end
}
