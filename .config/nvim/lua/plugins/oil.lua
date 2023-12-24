return {
	{
		"stevearc/oil.nvim",
		opts = {
			default_file_explorer = false,
		},
		dependencies = { "nvim-tree/nvim-web-devicons" },
		keys = {
			{
				"<leader>o",
				mode = "n",
				"<CMD>Oil --float<CR>",
				-- function()
				-- 	require("oil").toggle()
				-- end,
				desc = "Open Oil",
			},
		},
	},
}
