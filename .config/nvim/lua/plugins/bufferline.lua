return {
	{
		"akinsho/bufferline.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {
			options = {
				mode = "tabs",
				always_show_bufferline = true,
				show_buffer_close_icons = false,
				show_close_icon = false,
				color_icons = true,
				diagnostics = "nvim_lsp",
				offsets = {
					{
						filetype = "neo-tree",
						text = "Neo-tree",
						highlight = "Directory",
						text_align = "left",
					},
				},
			},
		},
		keys = {
			{ "P", "<Cmd>BufferLineTogglePin<CR>", desc = "Toggle pin" },
		},
	},
}
