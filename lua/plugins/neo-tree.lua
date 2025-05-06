return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},
	lazy = false,
	---@module "neo-tree"
	---@type neotree.Config?
	opts = {
		enable_diagnostics = false,
		event_handlers = {
			{
				event = "before_render",
				handler = function(state)
					local root_path = state.path
					state.project_name = nil
					local dir_name = vim.fn.fnamemodify(root_path, ":t")
					state.project_name = dir_name
				end,
			},
		},
		filesystem = {
			components = {
				name = function(config, node, state)
					local cc = require("neo-tree.sources.common.components")
					local result = cc.name(config, node, state)
					if node:get_depth() == 1 and state.project_name then
						result.text = state.project_name
					end
					return result
				end,
			},
			filtered_items = {
				visible = false, -- when true, they will just be displayed differently than normal items
				hide_dotfiles = false,
				hide_gitignored = false,
				hide_hidden = false, -- only works on Windows for hidden files/directories
				hide_by_name = {
					".git",
					".DS_Store",
					--"node_modules",
				},
				hide_by_pattern = {
					--"*.meta",
					--"*/src/*/tsconfig.json",
				},
				always_show = { -- remains visible even if other settings would normally hide it
					--".gitignored",
				},
				always_show_by_pattern = { -- uses glob style patterns
					--".env*",
				},
				never_show = { -- remains hidden even if visible is toggled to true, this overrides always_show
					--".DS_Store",
					--"thumbs.db",
				},
				never_show_by_pattern = { -- uses glob style patterns
					--".null-ls_*",
				},
			},
		},
		window = {
			mappings = {
				["P"] = { "toggle_preview", config = { use_float = true, use_image_nvim = false } },
				["l"] = "focus_preview",
				["<C-b>"] = { "scroll_preview", config = { direction = 10 } },
				["<C-f>"] = { "scroll_preview", config = { direction = -10 } },
			},
		},
	},
}
