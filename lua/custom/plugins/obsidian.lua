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
          path = "~/personal/AaronVault/",
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
      daily_notes = {
        -- optional, if you keep daily notes in a separate directory.
        folder = "AaronVault/Streams",
        -- optional, if you want to change the date format for the id of daily notes.
        date_format = "%Y-%m-%d",
        -- optional, if you want to change the date format of the default alias of daily notes.
        alias_format = "Streams",
        -- optional, default tags to add to each new daily note created.
        default_tags = { "Streams" },
        -- optional, if you want to automatically insert a template from your template directory like 'daily.md'
        template = nil
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
