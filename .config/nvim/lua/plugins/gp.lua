return {
	{
		"robitx/gp.nvim",
		keys = {
			{
				"<leader>ar",
				mode = { "n", "x", "o", "v" },
				":GpRewrite<CR>",
				desc = "Speak to AI with current selection -- replaces current section",
			},
			{
				"<leader>an",
				mode = { "n", "x", "o", "v" },
				":GpAppend<CR>",
				desc = "Speak to AI with current selection -- appends below",
			},
			{
				"<leader>ai",
				mode = { "n", "x", "o", "v" },
				":GpImplement<CR>",
				desc = "Speak to AI with current selection -- implements current selection comments",
			},
		},
		config = function()
			require("gp").setup()

			-- or setup with your own config (see Install > Configuration in Readme)
			-- require("gp").setup(config)

			-- shortcuts might be setup here (see Usage > Shortcuts in Readme)
		end,
	},
}
