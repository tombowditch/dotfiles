vim.opt.relativenumber = true
vim.opt.nu = true
vim.opt.smartindent = true
vim.opt.wrap = true
vim.g.mapleader = ","
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.clipboard = "unnamedplus"
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true
vim.opt.updatetime = 50
vim.opt.guifont = "Berkeley Mono:h14"
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.termguicolors = true
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.cursorline = true
vim.opt.scrolloff = 5
vim.opt.wrap = true

vim.api.nvim_create_autocmd("BufWritePost", {
	pattern = { "*tmux.conf" },
	command = "execute 'silent !tmux source <afile> --silent'",
})
