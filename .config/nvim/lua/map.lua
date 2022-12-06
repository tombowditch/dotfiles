local status, comments = pcall(require, "Comment.api")
if not status then
	return
end

local o = { silent = true }

vim.keymap.set("n", "<leader>/", comments.call("toggle.linewise.current", "g@$"), { expr = true, silent = true })
vim.keymap.set("n", "<C-d>", "<C-d>zz", o)
vim.keymap.set("n", "<C-u>", "<C-u>zz", o)
vim.keymap.set("n", "n", "nzzzv", o)
vim.keymap.set("n", "N", "Nzzzv", o)
