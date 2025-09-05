return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.8",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		local builtin = require("telescope.builtin")

		-- Just your custom keymaps — no config changes
		vim.keymap.set("n", "<leader><leader>", builtin.find_files, { desc = "Find files" })
		vim.keymap.set("n", "<leader>/", builtin.live_grep, { desc = "Live grep root" })
		vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Find buffers" })
		vim.keymap.set("n", "<leader>h", builtin.help_tags, { desc = "Search Neovim help" })
		vim.keymap.set("n", "<leader>r", builtin.resume, { desc = "Resume previous search" })

		-- Search Neovim config files
		vim.keymap.set("n", "<leader>fn", function()
			builtin.find_files({ cwd = vim.fn.stdpath("config") })
		end, { desc = "Find Neovim config files" })

		-- Grep Neovim config
		vim.keymap.set("n", "<leader>gn", function()
			builtin.live_grep({ cwd = vim.fn.stdpath("config") })
		end, { desc = "Grep Neovim config files" })

		-- Reference project search (~/Projects/Coding/)
		vim.keymap.set("n", "<leader>fp", function()
			builtin.find_files({ cwd = "~/Projects/Coding" })
		end, { desc = "Find project files (Coding dir)" })

		vim.keymap.set("n", "<leader>gp", function()
			builtin.live_grep({ cwd = "~/Projects/Coding" })
		end, { desc = "Grep project files (Coding dir)" })
	end,
}
