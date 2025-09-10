return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	opts = {
		options = {
			disabled_filetypes = {
				statusline = { "snacks_dashboard" },
				-- winbar = { "neo-tree", "Neotree", "NeoTree", "snacks_dashboard", "dashboard" },
			},
			globalstatus = true,
		},
	},
}
