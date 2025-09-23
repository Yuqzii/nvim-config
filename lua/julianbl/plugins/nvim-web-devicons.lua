return {
	"nvim-tree/nvim-web-devicons",
	config = function()
		local devicons = require("nvim-web-devicons")
		devicons.setup({
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

		vim.api.nvim_set_hl(0, "Dockerfile", { fg = "#458EE6" })
		local original_get_icon = devicons.get_icon
		devicons.get_icon = function(filename, ext, opts)
			if filename:match("^Dockerfile") then
				return "", "Dockerfile"
			end

			return original_get_icon(filename, ext, opts)
		end
	end
}
