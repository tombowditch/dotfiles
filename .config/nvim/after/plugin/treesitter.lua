local status, ts = pcall(require, "nvim-treesitter.configs")
if (not status) then return end

ts.setup {
  highlight = {
    enable = true,
    disable = {},
  },
  indent = {
    enable = true,
    disable = {},
  },
  ensure_installed = {
    "tsx",
    "toml",
    "json",
    "yaml",
    "css",
    "html",
    "lua",
    "prisma",
    "go",
    "rust",
    "help"
  },
  ignore_install = {
    "phpdoc"
  },
  autotag = {
    enable = true,
  },
}