vim.g.mapleader = " "
-- vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

vim.g.netrw_bufsettings = "noma nomod nu nowrap ro nobl"
vim.cmd("autocmd FileType netrw set nu")

-- navigate the quickfix/location list in normal mode
vim.keymap.set('n', '<C-[>', ':cp<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<C-]>', ':cn<CR>', { noremap = true, silent = true })

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

-- used to see diagnostics
vim.keymap.set("n", "gl", function() vim.diagnostic.open_float() end)

-- used to single file diagnostics in qflist
vim.keymap.set("n", "<C-x>", ":Telescope diagnostics<CR>")

-- Map to change split size
vim.keymap.set("n", "<C-Left>", "<C-w>10<")
vim.keymap.set("n", "<C-Right>", "<C-w>10>")
vim.keymap.set("n", "<C-Down>", "<C-w>10+")
vim.keymap.set("n", "<C-Up>", "<C-w>10-")

-- create splits
vim.keymap.set("n", "<leader>1", "<C-w>v<C-w>l")
vim.keymap.set("n", "<leader>2", "<C-w>s<C-w>j")

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

-- define a function for creating a small terminal
vim.keymap.set("n", "<leader>st", function()
  vim.cmd.new()
  vim.cmd.term()
  vim.cmd.wincmd("J")
  vim.api.nvim_win_set_height(0, 12)
end)

-- Define a function for creating a split terminal
vim.keymap.set("n", "<leader>t", function()
  vim.cmd.new()
  vim.cmd.term()
  vim.cmd.wincmd("L")
end)

-- source lua file
vim.keymap.set("n", "<leader><leader>", function()
  vim.cmd("so")
end)
