local status, comments = pcall(require, "Comment.api")
if not status then
	return
end

local o = { silent = true }

vim.keymap.set("n", "<leader>/", comments.call("toggle.linewise.current", "g@$"), { expr = true, silent = true })
