return {
	{
		"ibhagwan/fzf-lua",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("fzf-lua").setup({
				-- aa
			})
		end,

		-- keybinds
		keys = {
			{
				";f",
				function()
					require("fzf-lua").files({})
				end,
			},
			{
				";g",
				function()
					require("fzf-lua").live_grep({})
				end,
			},
			{
				"\\\\",
				function()
					require("fzf-lua").buffers({})
				end,
			},
			{
				";;",
				function()
					require("fzf-lua").resume({})
				end,
			},
			{
				";e",
				function()
					require("fzf-lua").diagnostics_workspace({})
				end,
			},
			{
				";r",
				function()
					require("fzf-lua").oldfiles({ cwd_only = true, include_current_session = true })
				end,
			},
		},
	},
}
