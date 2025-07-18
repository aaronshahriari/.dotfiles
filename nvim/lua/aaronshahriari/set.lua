-- not allow the mouse
-- vim.o.mouse = ""

-- insert block
vim.opt.guicursor = {
  "a:blinkon0",
  "n-v-c:block-Cursor/lCursor"
}

-- insert thin
-- vim.opt.guicursor = {
--   "a:blinkon0",
--   "i:ver25",
--   "o:hor25"
-- }

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.colorcolumn = "80"

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = true
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scroll = 25
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.opt.list = false
vim.opt.listchars:append({ tab = '  ', nbsp = ' ', trail = ' ', eol = '↲' })

-- used for obsidian
vim.opt.conceallevel = 1

vim.opt.cursorline = false

-- create terminal config
vim.api.nvim_create_autocmd("TermOpen", {
  group = vim.api.nvim_create_augroup('custom-term-open', { clear = true }),
  callback = function()
    vim.opt_local.number = true
    vim.opt_local.relativenumber = true
    vim.opt_local.scrolloff = 0
  end,
})

-- set tabnames
vim.o.showtabline = 1 -- always show the tabline
vim.o.tabline = '%!v:lua.MyTabline()'

-- custom tabline function
function MyTabline()
  local s = ''
  for i = 1, vim.fn.tabpagenr('$') do
    local winnr = vim.fn.tabpagewinnr(i)           -- get the window number for the tab
    local bufnr = vim.fn.tabpagebuflist(i)[winnr]  -- get the buffer for the window
    local bufname = vim.fn.bufname(bufnr)          -- get the buffer name
    local file = vim.fn.fnamemodify(bufname, ':t') -- extract only the file name

    -- -- handle [No Name] as oil tree
    if file == '' then
      file = 'Oil'
    end

    -- highlight the current tab
    if i == vim.fn.tabpagenr() then
      s = s .. '%#TabLineSel# ' .. (file ~= '' and file or '[No Name]') .. ' %#TabLine#'
    else
      s = s .. '%#TabLine# ' .. (file ~= '' and file or '[No Name]') .. ' '
    end
  end
  return s
end

-- removing next line comments automatically
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
local FormatOptions = augroup("FormatOptions", { clear = true })
autocmd("BufEnter", {
  group = FormatOptions,
  pattern = "*",
  callback = function()
    vim.opt_local.formatoptions:remove({ "r", "o", })
  end,
})

-- clipboard config
vim.g.clipboard = {
  name = "wl-clipboard",
  copy = {
    ["+"] = "wl-copy",
    ["*"] = "wl-copy",
  },
  paste = {
    ["+"] = "wl-paste",
    ["*"] = "wl-paste",
  },
  cache_enabled = 0,
}

vim.api.nvim_set_hl(0, "FixmeComment", { fg = "black", bg = "#cfa942", bold = true })

vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*",
  callback = function()
    vim.fn.matchadd("FixmeComment", [[\v(\/\/|\#|\-\-|\*)[^\n]*\zsFIXME:]])
  end,
})
