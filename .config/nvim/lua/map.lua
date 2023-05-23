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
vim.keymap.set("x", "p", '"_dP', o)

-- don't auto comment new line
vim.api.nvim_create_autocmd("BufEnter", { command = [[set formatoptions-=cro]] })

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
