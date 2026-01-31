return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		{ "antosha417/nvim-lsp-file-operations", config = true },
	},
	config = function()
		local cmp_nvim_lsp = require("cmp_nvim_lsp")

		-- The lsp stuff doesn't want to work with the normal on_attach for some reason
		vim.api.nvim_create_autocmd("LspAttach", {
			callback = function(ev)
				local opts = { buffer = ev.buf, remap = false, silent = true }

				opts.desc = "Show line diagnostic"
				vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)

				opts.desc = "Show buffer diagnostics"
				vim.keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts)

				opts.desc = "Show LSP references"
				vim.keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts)

				opts.desc = "Go to declaration"
				vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)

				opts.desc = "Show LSP definitions"
				vim.keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)

				opts.desc = "See available code actions"
				vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)

				opts.desc = "Smart rename"
				vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

				opts.desc = "Go to previous diagnostic"
				vim.keymap.set("n", "[d", "<cmd>lua vim.diagnostic.jump({ count = -1 })<CR>", opts)

				opts.desc = "Go to next diagnostic"
				vim.keymap.set("n", "]d", "<cmd>lua vim.diagnostic.jump({ count = 1 })<CR>", opts)

				opts.desc = "Show documentation for what is under cursor"
				vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)

				opts.desc = "Restart LSP"
				vim.keymap.set("n", "<leader>rs", "<cmd>LspRestart<CR>", opts)
			end,
		})


		-- Used to enable autocompletion (assign to every lsp server config)
		local capabilities = cmp_nvim_lsp.default_capabilities()

		vim.diagnostic.config({
			signs = {
				text = {
					[vim.diagnostic.severity.ERROR] = '',
					[vim.diagnostic.severity.WARN] = '',
					[vim.diagnostic.severity.INFO] = '',
					[vim.diagnostic.severity.HINT] = '󰌵',
				},
			},
			jump = {
				float = true,
				wrap = true,
			},
		})

		vim.lsp.config("*", {
			capabilities = capabilities,
		})
		-- Configure Lua server
		vim.lsp.config("lua_ls", {
			capabilities = capabilities,
			settings = {
				Lua = {
					diagnostics = { -- Make it recognize "vim" global
						globals = { "vim" },
					},
					workspace = {
						library = { -- Make it aware of runtime files
							[vim.fn.expand("$VIMRUNTIME/lua")] = true,
							[vim.fn.stdpath("config") .. "/lua"] = true,
						},
					},
				},
			},
		})
	end
}
