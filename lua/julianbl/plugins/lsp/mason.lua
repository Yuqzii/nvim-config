return {
	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
	},
	config = function()
		local mason = require("mason")
		local mason_lspconfig = require("mason-lspconfig")

		mason.setup({
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				}
			}
		})

		mason_lspconfig.setup({
			ensure_installed = {
				"clangd",
				"lua_ls",
				"pyright",
				"gopls",
				"golangci_lint_ls",
				"html",
				"cssls",
				"ts_ls",
				"eslint",
				"css_variables",
			},
			automatic_installation = true,
			automatic_enable = true,
		})
	end
}
