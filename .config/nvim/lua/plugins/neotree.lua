return {
	{
		"nvim-neo-tree/neo-tree.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
		},
		branch = "v3.x",
		cmd = "Neotree",
		opts = {
			auto_clean_after_session_restore = true,
			close_if_last_window = false,
			popup_border_style = "rounded",
			enable_git_status = true,
			enable_diagnostics = true,
			filesystem = {
				bind_to_cwd = true,
				follow_current_file = {
					enabled = true,
				},
				use_libuv_file_watcher = true,
			},
			default_component_configs = {
				indent = {
					with_expanders = true,
					expander_collapsed = "",
					expander_expanded = "",
					expander_highlight = "NeoTreeExpander",
				},
			},
		},
		keys = {
			{
				";t",
				"<Cmd>Neotree toggle<CR>",
				desc = "Toggle Neo-tree",
			},
		},
	},
}
