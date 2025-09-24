require("julianbl.config.remap")
require("julianbl.config.lazy")

vim.o.number = true
vim.o.relativenumber = true
vim.o.guicursor = "n-v-i-c:block-Cursor" -- Always use block cursor

local tab = 4
vim.o.tabstop = tab
vim.o.softtabstop = tab
vim.o.shiftwidth = tab
vim.o.smartindent = true

vim.o.splitright = true

vim.o.wrap = false

vim.o.swapfile = false
vim.o.backup = false
vim.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.o.undofile = true

vim.o.hlsearch = false
vim.o.incsearch = true

vim.o.termguicolors = true

vim.o.signcolumn = "yes"
vim.o.scrolloff = 8

vim.o.updatetime = 50

local colcolumn = 100
vim.o.colorcolumn = "" .. colcolumn
-- Gruvbox colorcolumn
vim.cmd("hi ColorColumn ctermbg=235 guibg=#3c3836")
-- Catppuccin colorcolumn
--vim.cmd("hi ColorColumn ctermbg=235 guibg=#494d64")
vim.cmd("autocmd WinLeave * set colorcolumn=0")
vim.cmd("autocmd WinEnter * set colorcolumn=" .. colcolumn)

vim.o.mouse = ""

vim.api.nvim_create_augroup("AutoFormat", {})
vim.api.nvim_create_autocmd(
	"BufWritePost",
	{
		pattern = "*.go",
		group = "AutoFormat",
		callback = function()
			local save = vim.fn.winsaveview()
			vim.cmd("silent !gofmt -w -s ./")
			vim.cmd("edit")
			vim.fn.winrestview(save)
		end,
	}
)
vim.api.nvim_create_autocmd(
	"BufWritePost",
	{
		group = "AutoFormat",
		callback = function()
			local save = vim.fn.winsaveview()
			vim.cmd("silent lua vim.lsp.buf.format()")
			vim.fn.winrestview(save)
		end,
	}
)

vim.cmd [[
	highlight Normal guibg=none
	highlight NonText guibg=none
	highlight Normal ctermbg=none
	highlight NonText ctermbg=none
]]
