local Terminal = require("toggleterm.terminal").Terminal
local lazygit = Terminal:new({ cmd = "lazygit", hidden = true })

function _LAZYGIT_TOGGLE()
	lazygit:toggle()
end

vim.keymap.set("n", "<leader>gg", function()
	_LAZYGIT_TOGGLE()
end, { silent = true })
