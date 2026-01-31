return {
	"christoomey/vim-tmux-navigator",
	lazy = false,
	priority = 200,
	init = function()
        -- Tell the plugin not to create any mappings
        vim.g.vim_tmux_navigator_no_mappings = 1
    end,
	config = function()
        local map_opts = { silent = true }
        vim.keymap.set("n", "<C-w>h", "<cmd>TmuxNavigateLeft<cr>", map_opts)
        vim.keymap.set("n", "<C-w>j", "<cmd>TmuxNavigateDown<cr>", map_opts)
        vim.keymap.set("n", "<C-w>k", "<cmd>TmuxNavigateUp<cr>", map_opts)
        vim.keymap.set("n", "<C-w>l", "<cmd>TmuxNavigateRight<cr>", map_opts)
        vim.keymap.set("n", "<C-w>\\", "<cmd>TmuxNavigatePrevious<cr>", map_opts)
    end,
}
