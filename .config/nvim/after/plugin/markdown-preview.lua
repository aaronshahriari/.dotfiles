vim.g.mkdp_auto_start = 1

vim.cmd([[
function OpenMarkdownPreview (url)
	let l:mdp_browser = '/mnt/c/Program\ Files/Google/Chrome/Application/chrome.exe'
	let l:mdp_browser_opts = '--new-window'
	execute join(['silent! !', l:mdp_browser, l:mdp_browser_opts, a:url])
endfunction
]])

vim.cmd([[
let g:mkdp_markdown_css = expand('~/.config/nvim/styles/markdown.css')
let g:mkdp_highlight_css = expand('~/.config/nvim/styles/highlight.css')
]])
vim.g.mkdp_browserfunc = 'OpenMarkdownPreview'
