local M = {}

-- ========================================
-- Current theme handling (persistent)
-- ========================================

-- Default theme
M.theme = "tokyonight-storm"

-- File to persist current theme
local theme_file = vim.fn.stdpath("config") .. "/data/current_theme.txt"

-- Load persisted theme if it exists
if vim.fn.filereadable(theme_file) == 1 then
	local f = io.open(theme_file, "r")
	if f then
		M.theme = f:read("*l") or M.theme
		f:close()
	end
end

-- Function to set and persist the theme
function M.set_theme(theme)
	M.theme = theme
	local f = io.open(theme_file, "w")
	if f then
		f:write(theme)
		f:close()
	end
end

-- ========================================
-- Dynamic theme collection from plugins/themes
-- ========================================

local function get_available_themes()
	local themes_dir = vim.fn.stdpath("config") .. "/lua/plugins/themes"
	local themes = {}

	for _, file in ipairs(vim.fn.globpath(themes_dir, "*.lua", true, true)) do
		local fname = vim.fn.fnamemodify(file, ":t:r")
		local ok, plugin_tbl = pcall(require, "plugins.themes." .. fname)
		if ok and type(plugin_tbl) == "table" and plugin_tbl.themes and type(plugin_tbl.themes) == "table" then
			for _, t in ipairs(plugin_tbl.themes) do
				table.insert(themes, t)
			end
		end
	end

	return themes
end

M.themes = get_available_themes()

-- ========================================
-- Apply the persisted theme at startup
-- ========================================

local function apply_theme(theme_name)
	if theme_name:match("tokyonight") then
		vim.g.tokyonight_style = theme_name:match("tokyonight%-([%w_]+)") or "storm"
	elseif theme_name:match("onedark") then
		vim.g.onedarkpro_style = theme_name:match("onedark[_%w]*") or "onedark"
	end

	local base_name = theme_name:gsub("[-_][%w_]+$", "")
	vim.cmd.colorscheme(base_name)
end

-- Apply theme on require
pcall(function()
	apply_theme(M.theme)
end)

-- ========================================
-- Telescope theme picker
-- ========================================

function M.select_theme()
	local pickers = require("telescope.pickers")
	local finders = require("telescope.finders")
	local actions = require("telescope.actions")
	local action_state = require("telescope.actions.state")
	local conf = require("telescope.config").values

	-- Find the index of the current theme
	local default_index = 1
	for i, t in ipairs(M.themes) do
		if t == M.theme then
			default_index = i
			break
		end
	end

	pickers
		.new({}, {
			prompt_title = "Select Colorscheme",
			finder = finders.new_table({ results = M.themes }),
			sorter = conf.generic_sorter({}),
			default_selection = default_index, -- preselect current theme
			layout_strategy = "center",
			layout_config = { width = 0.4, height = 0.3 },

			attach_mappings = function(prompt_bufnr, map)
				local function preview_theme()
					local selection = action_state.get_selected_entry()
					if selection then
						local theme_name = selection[1]
						apply_theme(theme_name)
						M.set_theme(theme_name)
					end
				end

				for _, mode in ipairs({ "i", "n" }) do
					map(mode, "<Down>", function()
						actions.move_selection_next(prompt_bufnr)
						preview_theme()
					end)
					map(mode, "<Up>", function()
						actions.move_selection_previous(prompt_bufnr)
						preview_theme()
					end)
				end

				actions.select_default:replace(function()
					actions.close(prompt_bufnr)
					local selection = action_state.get_selected_entry()
					if selection then
						preview_theme()
					end
				end)

				return true
			end,
		})
		:find()
end

return M
