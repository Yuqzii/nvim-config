return {
	"nvim-tree/nvim-web-devicons",
	config = function()
		require("nvim-web-devicons").setup({
			default = true,
			strict = true,
			variant = "dark",

			override_by_extension = {
				["go"] = {
					icon = "",
					color = "#00aed8",
					name = "Go",
				},
			},

			override_by_filename = {
				["go.mod"] = {
					icon = "",
					color = "#00aed8",
					name = "Go",
				},
				["go.sum"] = {
					icon = "",
					color = "#00aed8",
					name = "Go",
				},
			},
		})
	end
}
