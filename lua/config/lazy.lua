local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	local repo = "https://github.com/folke/lazy.nvim.git"
	local result = vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"--branch=stable",
		repo,
		lazypath,
	})
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_err_writeln("Failed to clone lazy.nvim:\n" .. result)
		os.exit(1)
	end
end

vim.opt.rtp:prepend(lazypath)

-- core configuration
require("config.options")
require("config.keymaps")
require("config.lsps")

require("lazy").setup({
	spec = {
		{ import = "plugins" },

		{
			"williamboman/mason.nvim",
			opts = {},
		},
	},
	install = { colorscheme = { "tokyonight-storm" } },
	checker = { enabled = true },
})

vim.cmd.colorscheme("tokyonight-storm")
