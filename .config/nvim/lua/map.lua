local status, comments = pcall(require, "Comment.api")
if not status then
    return
end

local o = {
    silent = true
}

vim.keymap.set("n", "<leader>/", comments.call("toggle.linewise.current", "g@$"), {
    expr = true,
    silent = true
})
vim.keymap.set("n", "<C-d>", "<C-d>zz", o)
vim.keymap.set("n", "<C-u>", "<C-u>zz", o)
vim.keymap.set("n", "n", "nzzzv", o)
vim.keymap.set("n", "N", "Nzzzv", o)
vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "<leader>gg", function()
    _LAZYGIT_TOGGLE()
end, o)
vim.keymap.set("n", "<leader>S", "<cmd>lua require('spectre').open()<CR>", o)
vim.keymap.set("n", "<leader>sw", "<cmd>lua require('spectre').open_visual({select_word=true})<CR>", o)
