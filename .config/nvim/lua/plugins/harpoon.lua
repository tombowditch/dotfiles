return {
	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		keys = {
			{
				"<leader>ha",
				mode = { "n", "x", "o" },
				function()
					require("harpoon"):list():append()
				end,
				desc = "Append to Harpoon",
			},
			{
				"<leader>hr",
				mode = { "n", "x", "o" },
				function()
					require("harpoon"):list():remove()
				end,
				desc = "Remove file from Harpoon",
			},
			{
				"<leader>hh",
				mode = { "n", "x", "o" },
				function()
					require("harpoon").ui:toggle_quick_menu(require("harpoon"):list())
				end,
				desc = "Toggle Harpoon",
			},
		},
		config = function()
			local harpoon = require("harpoon")
			harpoon:setup()

			for i = 1, 9 do
				vim.keymap.set("n", "<leader>h" .. i, function()
					require("harpoon"):list():select(i)
				end)
			end
		end,
	},
}
