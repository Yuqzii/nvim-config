return {
	"hrsh7th/nvim-cmp",
	event = "InsertEnter",
	dependencies = {
		"hrsh7th/cmp-buffer", -- Source for text in buffer
		"hrsh7th/cmp-path", -- Source for file system paths
		"L3MON4D3/LuaSnip", -- Snippet engine
		"saadparwaiz1/cmp_luasnip", -- For autocompletion
		"rafamadriz/friendly-snippets", -- Useful snippets
	},
	config = function()
		local cmp = require("cmp")
		local luasnip = require("luasnip")
		-- Loads vscode-style snippets from installed plugins (e.g. friendly-snippets)
		require("luasnip.loaders.from_vscode").lazy_load()
		require("cmp").scroll_docs()
		cmp.setup({
			completion = {
				completeopt = "menu,menuone,preview,noselect",
			},
			snippet = { -- Configure how nvim-cmp interacts with snippet engine
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end,
			},
			mapping = cmp.mapping.preset.insert({
				["<C-k>"] = cmp.mapping.select_prev_item(),
				["<C-j>"] = cmp.mapping.select_next_item(),
				["<C-f>"] = cmp.mapping.scroll_docs(4),
				["<C-b>"] = cmp.mapping.scroll_docs(-4),
				["<C-Space>"] = cmp.mapping.complete(), -- Show completion suggestions
				["<C-w>"] = cmp.mapping.abort(), -- Close completion window
				["<CR>"] = cmp.mapping.confirm({ select = false }),
			}),
			sources = cmp.config.sources({ -- Sources for autocompletion, highest has higher priority
				{ name = "nvim_lsp" }, -- Language server
				{ name = "luasnip" }, -- Snippets
				{ name = "buffer" }, -- Text within current buffer
				{ name = "path" }, -- File system paths
			}),
		})
	end,
}
