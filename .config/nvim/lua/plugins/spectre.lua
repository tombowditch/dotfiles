return {
	{
		"nvim-pack/nvim-spectre",
		config = function()
			require("spectre").setup()
		end,
		keys = {
			{
				"<leader>S",
				function()
					require("spectre").toggle()
				end,
			},
		},
	},
}
