-- Attaches to every FileType mode
require 'lua.custom.plugins.colorizer'.setup({
	'lua',
	css = { rgb_fn = true, },
	html = { names = false, },
})
