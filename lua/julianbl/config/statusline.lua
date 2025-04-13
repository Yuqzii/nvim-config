local modes = {
  ["n"] = "NORMAL",
  ["no"] = "NORMAL",
  ["v"] = "VISUAL",
  ["V"] = "VISUAL LINE",
  [""] = "VISUAL BLOCK",
  ["s"] = "SELECT",
  ["S"] = "SELECT LINE",
  [""] = "SELECT BLOCK",
  ["i"] = "INSERT",
  ["ic"] = "INSERT",
  ["R"] = "REPLACE",
  ["Rv"] = "VISUAL REPLACE",
  ["c"] = "COMMAND",
  ["cv"] = "VIM EX",
  ["ce"] = "EX",
  ["r"] = "PROMPT",
  ["rm"] = "MOAR",
  ["r?"] = "CONFIRM",
  ["!"] = "SHELL",
  ["t"] = "TERMINAL",
}

local function get_hl(name)
	local ok, hl = pcall(vim.api.nvim_get_hl_by_name, name, true)
	if not ok then
		return
	end
	for _, key in pairs({"foreground", "background", "special"}) do
		if hl[key] then
			hl[key] = string.format("#%06x", hl[key])
		end
	end
	return hl
end

local statusLineCol = get_hl("StatusLine")
vim.cmd("hi StatusLineAccent guifg=" .. statusLineCol["foreground"] ..
	" guibg=" .. statusLineCol["background"])

local function mode()
	local current_mode = vim.api.nvim_get_mode().mode
	return string.format(" %s ", modes[current_mode]):upper()
end

local function update_mode_colors()
	local current_mode = vim.api.nvim_get_mode().mode
	local mode_color = "%#StatusLineAccent#"

	-- Could extend this function to update mode colors
	return mode_color
end

local function filepath()
	-- :~ replaces home dir with ~
	-- :. makes path relative to current directory
	-- :h reduces filename to only the head
	local fpath = vim.fn.fnamemodify(vim.fn.expand "%", ":~:.:h")
	if fpath == "" or fpath == "." then
		return " "
	end

	return string.format(" %%<%s/", fpath)
end

local function filename()
	local fname = vim.fn.expand "%:t"
	if fname == "" then
		return ""
	end
	return fname .. " "
end

local function lsp()
	local count = {}
	local levels = {
		errors = "Error",
		warnings = "Warn",
		info = "Info",
		hints = "Hint",
	}

	for k, level in pairs(levels) do
		count[k] = vim.tbl_count(vim.diagnostic.get(0, { severity = level }))
	end
	
	local errors = ""
	local warnings = ""
	local hints = ""
	local info = ""

	if count["errors"] ~= 0 then
		errors = "%#DiagnosticError# " .. count["errors"]
	end
	if count["warnings"] ~= 0 then
		warnings = " %#DiagnosticWarn# " .. count["warnings"]
	end
	if count["hints"] ~= 0 then
		hints = " %#DiagnosticHint#󰠠 " .. count["hints"]
	end
	if count["info"] ~= 0 then
		info = " %#DiagnosticInfo# " .. count["info"]
	end

	return errors .. warnings .. hints .. info .. " %#Normal#"
end

local function filetype()
	return string.format(" %s ", vim.bo.filetype):upper()
end

local function lineinfo()
	if vim.bo.filetype == "alpha" then
		return ""
	end
	return " %P %l:%c "
end

local vcs = function()
	local git_info = vim.b.gitsigns_status_dict
	if not git_info or git_info.head == "" then
		return ""
	end
	local added = git_info.added and ("%#GitSignsAdd#+" .. git_info.added .. " ") or ""
	local changed = git_info.changed and ("%#GitSignsChange#~" .. git_info.changed .. " ") or ""
	local removed = git_info.removed and ("%#GitSignsDelete#-" .. git_info.removed .. " ") or ""
	if git_info.added == 0 then
		added = ""
	end
	if git_info.changed == 0 then
		changed = ""
	end
	if git_info.removed == 0 then
		removed = ""
	end
	return table.concat {
		" ",
		added,
		changed,
		removed,
		" ",
		"%#GitSignsAdd# ",
		git_info.head,
		" %#Normal#",
	}
end

Statusline = {}
Statusline.active = function()
	return table.concat {
		"%#StatusLine#",
		update_mode_colors(),
		mode(),
		"%#StatusLine#",
		filepath(),
		filename(),
		"%#Normal#",
		lsp(),
		"%=%#StatusLineExtra#",
		filetype(),
		lineinfo(),
	}
end

function Statusline.inactive()
	return " %f"
end

function Statusline.short()
	return "%#StatusLineNC#  NvimTree"
end

-- Uncomment to enable this status line
--vim.api.nvim_exec([[
--	augroup Statusline
--	au!
--	au WinEnter,BufEnter * setlocal statusline=%!v:lua.Statusline.active()
--	au WinLeave,BufLeave * setlocal statusline=%!v:lua.Statusline.inactive()
--	au WinEnter,BufEnter,FileType NvimTree setlocal statusline=%!v:lua.Statusline.short()
--	augroup END
--]], false)

