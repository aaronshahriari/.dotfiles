return {
  "nvim-telescope/telescope.nvim",
  tag = "0.1.4",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local telescope = require("telescope")
    telescope.setup {
      defaults = {
        layout_strategy = 'horizontal',
        layout_config = { height = 0.75, width = 0.75 },
      },
    }

    local builtin = require('telescope.builtin')
    vim.keymap.set('n', '<leader>ff', function() builtin.find_files() end, {})
    vim.keymap.set('n', '<C-p>', function() builtin.git_files({ no_ignore = true }) end, {})
    vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
    vim.keymap.set("n", "<space>fh", builtin.help_tags)
    vim.keymap.set("n", "<space>fc", function()
      builtin.find_files { cwd = "/home/aaronshahriari/github/.dotfiles/nvim/" }
    end)
  end
}
