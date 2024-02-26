return {
	{
		"nvimtools/none-ls.nvim",
		config = function()
			local null_ls = require("null-ls")

			-- local augroup = vim.api.nvim_create_augroup("Format", {})

			null_ls.setup({
				sources = {
					-- FORMATTING
					null_ls.builtins.formatting.stylua,
					null_ls.builtins.formatting.prettierd,
					null_ls.builtins.formatting.buf,

					-- DIAGNOSTICS
					null_ls.builtins.diagnostics.buf,
					null_ls.builtins.diagnostics.checkmake,

					-- CODE ACTIONS
				},
			})
		end,
	},
}
