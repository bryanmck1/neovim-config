-- Config for enabling toggling through the available theme plugins installed in /plugins/themes/

local M = {}

-- All available themes and variants
M.themes = {
	"tokyonight-storm",
	"onedark",
	"onedark_vivid",
	"onedark_dark",
	"onelight",
	"vaporwave",
}

function M.select_theme()
	local pickers = require("telescope.pickers")
	local finders = require("telescope.finders")
	local actions = require("telescope.actions")
	local action_state = require("telescope.actions.state")
	local conf = require("telescope.config").values

	pickers
		.new({}, {
			prompt_title = "Select Colorscheme",
			finder = finders.new_table({ results = M.themes }),
			sorter = conf.generic_sorter({}),

			-- Make the window smaller
			layout_strategy = "center",
			layout_config = {
				width = 0.4, -- 40% of screen width
				height = 0.3, -- 30% of screen height
			},

			attach_mappings = function(prompt_bufnr, map)
				-- Helper: preview the currently selected theme
				local function preview_theme()
					local selection = action_state.get_selected_entry()
					if selection then
						vim.cmd.colorscheme(selection[1])
					end
				end

				-- Map up/down to move and preview
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

				-- Confirm selection
				actions.select_default:replace(function()
					actions.close(prompt_bufnr)
					local selection = action_state.get_selected_entry()
					if selection then
						vim.notify("Selected colorscheme: " .. selection[1])
						vim.cmd.colorscheme(selection[1])
					end
				end)

				return true
			end,
		})
		:find()
end

return M
