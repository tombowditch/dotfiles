return {
	{
		"NeogitOrg/neogit",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"sindrets/diffview.nvim",
		},
		keys = {
			{
				"<leader>gn",
				mode = { "n", "x", "o" },
				function()
					require("neogit").open()
				end,
				desc = "Open Neogit",
			},
		},
		config = true,
	},
}
