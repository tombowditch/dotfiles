local o = {
	silent = true,
}

vim.keymap.set("n", "<C-d>", "<C-d>zz", o)
vim.keymap.set("n", "<C-u>", "<C-u>zz", o)
vim.keymap.set("n", "n", "nzzzv", o)
vim.keymap.set("n", "N", "Nzzzv", o)
vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("x", "p", '"_dP', o)
vim.keymap.set("n", "<leader>lnd", function()
	vim.opt.relativenumber = false
end, o)
vim.keymap.set("n", "<leader>lne", function()
	vim.opt.relativenumber = true
end, o)

--- Remove all trailing whitespace on save
local TrimWhiteSpaceGrp = vim.api.nvim_create_augroup("TrimWhiteSpaceGrp", { clear = true })
vim.api.nvim_create_autocmd("BufWritePre", {
	command = [[:%s/\s\+$//e]],
	group = TrimWhiteSpaceGrp,
})

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
})
