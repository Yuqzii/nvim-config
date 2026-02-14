return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	lazy = false,
	build = ":TSUpdate",
	config = function()
		local treesitter = require("nvim-treesitter")
		treesitter.setup({
			highlight = {
				enable = true,
				disable = {},
			},
		})
		treesitter.install({ "c", "cpp", "lua", "go", "vim", "vimdoc", "javascript", "html", "python", "sql" })

		-- Force attach to Go files, didn't want to start otherwise for some reason.
		vim.api.nvim_create_autocmd("FileType", {
			pattern = "go",
			callback = function()
				vim.treesitter.start()
			end,
		})
	end
}
