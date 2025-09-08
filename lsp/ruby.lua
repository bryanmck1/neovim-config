return {
	cmd = { "ruby-lsp" }, -- the executable for Ruby LSP
	filetypes = { "ruby" },
	root_markers = { ".git", "Gemfile", ".rubocop.yml" }, -- directories that mark project root
	settings = {
		-- optional: customize LSP-specific settings
	},
}
