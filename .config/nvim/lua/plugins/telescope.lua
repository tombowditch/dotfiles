return {
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.5",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope-ui-select.nvim",
			"nvim-telescope/telescope-file-browser.nvim",
		},
		version = false,
		opts = {
			defaults = {
				mappings = {
					n = {
						["q"] = function(...)
							return require("telescope.actions").close(...)
						end,
					},
				},

				file_ignore_patterns = { "node_modules", "^.git/", ".git/" },
			},
			extensions = {
				file_browser = {
					theme = "dropdown",
					mappings = {
						["i"] = {
							["<C-w>"] = function()
								vim.cmd("normal vbd")
							end,
						},
						["n"] = {
							["N"] = function(...)
								return require("telescope").extensions.file_browser.actions.create(...)
							end,
							["h"] = function(...)
								return require("telescope").extensions.file_browser.actions.goto_parent_dir(...)
							end,
							["/"] = function()
								vim.cmd("startinsert")
							end,
						},
					},
				},
				["ui-select"] = function(...)
					return require("telescope.themes").get_dropdown(...)
				end,
				fzf = {
					fuzzy = true,
					override_generic_sorter = true,
					override_file_sorter = true,
					case_mode = "smart_case",
				},
			},
		},
		-- keybinds
		keys = {
			{
				";f",
				function()
					require("telescope.builtin").find_files({ hidden = true, respect_gitignore = false })
				end,
			},
			{
				";g",
				function()
					require("telescope.builtin").live_grep()
				end,
			},
			{
				"\\\\",
				function()
					require("telescope.builtin").buffers()
				end,
			},
			{
				";;",
				function()
					require("telescope.builtin").resume()
				end,
			},
			{
				";e",
				function()
					require("telescope.builtin").diagnostics()
				end,
			},
			{
				";F",
				function()
					require("telescope").extensions.file_browser.file_browser({
						path = "%:p:h",
						cwd = vim.fn.expand("%:p:h"),
						respect_gitignore = false,
						hidden = true,
						grouped = true,
						previewer = false,
						initial_mode = "insert",
						layout_config = { height = 40 },
					})
				end,
			},
		},
	},
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
	},
}
