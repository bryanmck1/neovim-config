return {
	"folke/snacks.nvim",
	---@type snacks.Config
	opts = {

		dashboard = {
			sections = {
				{ section = "header" },
				{ icon = " ", title = "Keymaps", section = "keys", indent = 2, padding = 1 },
				{
					icon = " ",
					title = "Projects",
					section = "projects",
					dirs = {
						"~/.config/nvim/",
						"~/Projects/Coding/pt3/",
						"~/Projects/Coding/rimcor-inspection-app/",
						"~/Projects/Coding/talent-dynamics/",
					},
					indent = 2,
					padding = 1,
				},
				{ section = "startup" },
			},
		},
	},
}
