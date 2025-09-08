return {
	"stevearc/conform.nvim",
	opts = {

		formatters_by_ft = {
			eruby = { "htmlbeautifier" },
			javascript = { "prettierd" },
			lua = { "stylua" },
			ruby = { "rubocop" },
		},

		format_on_save = {
			-- These options will be passed to conform.format()
			timeout_ms = 1000,
			lsp_format = "fallback",
		},
	},
}
