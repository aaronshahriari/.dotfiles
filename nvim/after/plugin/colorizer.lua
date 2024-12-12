-- Attaches to every FileType mode
require 'colorizer'.setup({
    'lua',
    css = { rgb_fn = true, },
    html = { names = false, },
})
