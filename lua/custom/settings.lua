vim.wo.relativenumber = true

-- yank to clipboard if possible
vim.opt.clipboard:append { 'unnamed', 'unnamedplus' }

-- netrw
vim.g.netrw_liststyle = 3
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25
vim.g.netrw_browse_split = 4
vim.g.netrw_altv = 1

local nmap = function(keys, func, desc)
	vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
end

-- Better navigation
nmap('<C-d>', '<C-d>zz')
nmap('<C-u>', '<C-u>zz')

nmap('gh', '0')
nmap('gl', '$')
