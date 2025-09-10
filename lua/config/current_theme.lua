local M = {}

-- Default theme if none has been selected yet
M.theme = "tokyonight-storm"

-- Load the persisted theme from disk if it exists
local theme_file = vim.fn.stdpath("config") .. "/current_theme.txt"
if vim.fn.filereadable(theme_file) == 1 then
	local f = io.open(theme_file, "r")
	if f then
		M.theme = f:read("*l") or M.theme
		f:close()
	end
end

-- Function to save a theme persistently
function M.set_theme(theme)
	M.theme = theme
	local f = io.open(theme_file, "w")
	if f then
		f:write(theme)
		f:close()
	end
end

return M
