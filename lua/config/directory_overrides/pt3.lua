local root = vim.loop.cwd()

if root:match("pt3$") then
	local conform = require("conform")

	conform.setup({
		format_on_save = function(bufnr)
			local ft = vim.bo[bufnr].filetype
			local ignore = { "eruby", "javascript", "ruby" }

			if vim.tbl_contains(ignore, ft) then
				return
			end

			return { timeout_ms = 1000, lsp_format = "fallback" }
		end,
	})
end
