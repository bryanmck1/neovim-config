return {
	"folke/flash.nvim",
	event = "VeryLazy",
	---@type Flash.Config
	opts = {},
	keys = {
		{
			"s",
			mode = { "n", "x", "o" },
			function()
				require("flash").jump()
			end,
			desc = "Flash",
		},
		{
			"S",
			mode = { "n", "x", "o" },
			function()
				require("flash").treesitter()
			end,
			desc = "Flash Treesitter",
		},
		{
			"r",
			mode = "o",
			function()
				require("flash").remote()
			end,
			desc = "Remote Flash",
		},
		{
			"R",
			mode = { "o", "x" },
			function()
				require("flash").treesitter_search()
			end,
			desc = "Treesitter Search",
		},
		{
			"<c-s>",
			mode = { "c" },
			function()
				require("flash").toggle()
			end,
			desc = "Toggle Flash Search",
		},
	},

	config = function()
		vim.api.nvim_set_hl(0, "FlashLabel", { fg = "#ffffff", bg = "#333333" })
		vim.api.nvim_set_hl(0, "FlashMatch", { fg = "#000000", bg = "#dddddd" })
		vim.api.nvim_set_hl(0, "FlashCurrent", { fg = "#ffffff", bg = "#007acc", bold = true })
		vim.api.nvim_set_hl(0, "FlashCursor", { fg = "#ffffff", bg = "#ff8800", bold = true })
		vim.api.nvim_set_hl(0, "FlashBackdrop", { fg = "#666666" })
		vim.api.nvim_set_hl(0, "FlashPrompt", { fg = "#ffffff", bg = "#222222" })
		vim.api.nvim_set_hl(0, "FlashPromptIcon", { fg = "#00ffff", bg = "#222222" })
	end,
}
