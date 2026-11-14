return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	lazy = false,
	build = ":TSUpdate",
	config = function()
		local treesitter = require("nvim-treesitter")
		treesitter.setup({})
		treesitter.install({ "c", "cpp", "lua", "go", "vim", "vimdoc", "javascript", "html", "python", "sql", "jinja", "jinja_inline", "css", "templ" })

		-- On the main branch, highlighting must be started explicitly per buffer.
		-- pcall skips filetypes without an installed parser.
		vim.api.nvim_create_autocmd("FileType", {
			callback = function(args)
				pcall(vim.treesitter.start, args.buf)
			end,
		})
	end
}
