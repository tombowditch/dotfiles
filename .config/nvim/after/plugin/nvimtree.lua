local status, nvimTree = pcall(require, "nvim-tree")
if (not status) then
    return
end

local function open_nvim_tree()
    require("nvim-tree.api").tree.open()
end

nvimTree.setup({})

vim.api.nvim_create_autocmd({"VimEnter"}, {
    callback = open_nvim_tree
})
