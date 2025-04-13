return {
	"kevinhwang91/nvim-ufo",
	priority = -100000000,
	dependencies = { "kevinhwang91/promise-async" },
	config = function()

		vim.o.foldcolumn = '0' -- '0' is not bad
		vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
		vim.o.foldlevelstart = 99
		vim.o.foldenable = true
		vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]

		-- Option 2: nvim lsp as LSP client
		-- Tell the server the capability of foldingRange,
		-- Neovim hasn't added foldingRange to default capabilities, users must add it manually
		local capabilities = vim.lsp.protocol.make_client_capabilities()
		capabilities.textDocument.foldingRange = {
			dynamicRegistration = false,
			lineFoldingOnly = true
		}
		local language_servers = vim.lsp.get_clients() -- or list servers manually like {'gopls', 'clangd'}
		for _, ls in ipairs(language_servers) do
			require('lspconfig')[ls].setup({
				capabilities = capabilities
				-- you can add other fields for setting up lsp server in this table
			})
		end
		require('ufo').setup({
			open_fold_hl_timeout = 150,
			close_fold_kinds_for_ft = {
				default = {'imports', 'comment'},
				json = {'array'},
				c = {'comment', 'region'}
			},
			preview = {
				win_config = {
					border = {'', '─', '', '', '', '─', '', ''},
					winhighlight = 'Normal:Folded',
					winblend = 0
				},
				mappings = {
					scrollU = '<C-u>',
					scrollD = '<C-d>',
					jumpTop = '[',
					jumpBot = ']'
				}
			},
			provider_selector = function(bufnr, filetype, buftype)
				-- if you prefer treesitter provider rather than lsp,
				-- return ftMap[filetype] or {'treesitter', 'indent'}
				return {"treesitter", "indent"}

				-- refer to ./doc/example.lua for detail
			end
		})
		vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
		vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)
		vim.keymap.set('n', 'zr', require('ufo').openFoldsExceptKinds)
		vim.keymap.set('n', 'zm', require('ufo').closeFoldsWith) -- closeAllFolds == closeFoldsWith(0)
		vim.keymap.set('n', 'L', function()
			local winid = require('ufo').peekFoldedLinesUnderCursor()
		end)
	end
}
