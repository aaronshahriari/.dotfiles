vim.g.mapleader = " "
-- vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

vim.g.netrw_bufsettings = "noma nomod nu nowrap ro nobl"
vim.cmd("autocmd FileType netrw set nu")

-- navigate the quickfix/location list in normal mode
vim.keymap.set('n', '<C-[>', ':cp<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<C-]>', ':cn<CR>', { noremap = true, silent = true })

-- scrolling horizontally with the mouse (csv files ofc)
vim.keymap.set('n', '<S-ScrollWheelUp>', '10zh', { silent = true })
vim.keymap.set('n', '<S-ScrollWheelDown>', '10zl', { silent = true })

-- I just need this fr
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

-- Map these to move through splits
vim.keymap.set("n", "<C-h>", "<C-w><C-h>")
vim.keymap.set("n", "<C-l>", "<C-w><C-l>")
vim.keymap.set("n", "<C-j>", "<C-w><C-j>")
vim.keymap.set("n", "<C-k>", "<C-w><C-k>")
vim.keymap.set("n", "<C-T>", "<C-w>T")

-- Map these to move through tabs
vim.keymap.set("n", "<Left>", "gT")
vim.keymap.set("n", "<Right>", "gt")

-- Map these to move through tabs
vim.keymap.set("n", "<S-Left>", function() vim.cmd("tabmove -1") end)
vim.keymap.set("n", "<S-Right>", function() vim.cmd("tabmove +1") end)

-- close entire tab
vim.keymap.set("n", "dby", ":tabnew | DBUI<CR>", { noremap = true, silent = true })

-- used to see diagnostics
vim.keymap.set("n", "gl", function() vim.diagnostic.open_float() end)

-- used to single file diagnostics in qflist
-- vim.keymap.set("n", "<C-x>", ":Telescope diagnostics<CR>")

-- Map to change split size
vim.keymap.set("n", "<C-Left>", "<C-w>10<")
vim.keymap.set("n", "<C-Right>", "<C-w>10>")
vim.keymap.set("n", "<C-Down>", "<C-w>10+")
vim.keymap.set("n", "<C-Up>", "<C-w>10-")

-- create splits
vim.keymap.set("n", "<leader>1", "<C-w>v")
vim.keymap.set("n", "<leader>2", "<C-w>s")

-- map all splits set equal
vim.keymap.set("n", "<leader>=", "<C-w>=")

-- Map <leader>-n to open a new tab
vim.keymap.set("n", "<leader>n", ":tabnew<CR>")

-- next greatest remap ever : asbjornHaland
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]])

-- flip flop visual line blocks
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- get to normal mode in terminal
vim.keymap.set("t", "<ESC>", [[<C-\><C-n>]])

-- run tmux inside of vim
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww ~/.local/bin/scripts/tmux-sessionizer.sh<CR>")
vim.keymap.set("n", "<C-g>", "<cmd>silent !tmux neww ~/.local/bin/scripts/tmux-sessionizer.sh -s 0<CR>")
vim.keymap.set("n", "<C-a>", "<cmd>silent !~/.local/bin/scripts/tmux-sessionizer.sh -s 0 --vsplit --split-size 35<CR>")

-- source lua file
vim.keymap.set("n", "<leader><leader>", function()
  vim.cmd("so")
end)

-- define a function for creating a small terminal
vim.keymap.set("n", "<leader>st", function()
  vim.cmd.new()
  vim.cmd.term()
  vim.cmd.wincmd("J")
  local total_height = vim.api.nvim_list_uis()[1].height
  vim.api.nvim_win_set_height(0, math.floor(total_height * 0.3))
end)

-- define a function for creating a split terminal
vim.keymap.set("n", "<leader>t", function()
  vim.cmd.new()
  vim.cmd.term()
  vim.cmd.wincmd("L")
  local total_width = vim.api.nvim_list_uis()[1].width
  vim.api.nvim_win_set_width(0, math.floor(total_width * 0.4))
end)
