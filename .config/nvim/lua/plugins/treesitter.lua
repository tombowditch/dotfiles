return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    cmd = { "TSUpdateSync" },
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      local configs = require('nvim-treesitter.configs')

      configs.setup({
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
          "help",
          "markdown",
          "markdown_inline"
        },
        ignore_install = {
          "phpdoc"
        },
        autotag = {
          enable = true,
        },
      })
    end,
  }
}
