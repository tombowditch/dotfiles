local lsp = require('lsp-zero')
lsp.preset('recommended')


local status, saga = pcall(require, "lspsaga")
if (not status) then return end

-- saga.init_lsp_saga {
--   code_action_lightbulb = {
--     enable = false
--   }
-- }

saga.setup({
  lightbulb = {
    enable = false
  }
})

lsp.ensure_installed({
  'tsserver',
  'eslint',
  'rust_analyzer',
  'gopls'
})

local cmp = require("cmp")
local cmp_select = { behaviorr = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings({
  ["<CR>"] = cmp.mapping.confirm(cmp_select),
})
-- copilot
cmp_mappings["<Tab>"] = nil
cmp_mappings["<S-Tab>"] = nil

lsp.setup_nvim_cmp({
  mapping = cmp_mappings
})

lsp.on_attach(function(client, bufnr)
  local bufopts = { noremap = true, silent = true, buffer = bufnr }

  vim.keymap.set("n", "<leader>e", "<cmd>lua vim.diagnostic.open_float()<CR>", bufopts)
  -- vim.keymap.set('n', 'K', '<Cmd>Lspsaga hover_doc<CR>', bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gd', '<Cmd>Lspsaga lsp_finder<CR>', bufopts)
  vim.keymap.set('n', 'gR', '<Cmd>Lspsaga rename<CR>', bufopts)
  vim.keymap.set('n', 'gc', '<Cmd>Lspsaga code_action<CR>', bufopts)
end)

-- rust tools
local rust_lsp = lsp.build_options("rust_analyzer", {
  settings = {
    ["rust-analyzer"] = {
      checkOnSave = {
        allFeatures = true,
        command = "clippy"
      }
    }
  }
})


-- Initialize rust_analyzer with rust-tools
require("rust-tools").setup({
  server = rust_lsp,
  tools = {
    inlay_hints = {
      auto = true,
    }
  }
})

lsp.format_on_save({
  format_opts = {
    timeout_ms = 10000,
  },
  servers = {
    ['null-ls'] = { 'javascript', 'typescript', 'lua', 'javascriptreact', 'typescriptreact' },
    ["rust_analyzer"] = { "rust" },
    ["gopls"] = { "go" },
    ["prismals"] = { "prisma" },
  }
})

lsp.nvim_workspace()

lsp.setup()

vim.diagnostic.config({
  virtual_text = true,
})

local null_ls = require('null-ls')
local null_opts = lsp.build_options('null-ls', {})

null_ls.setup({
  on_attach = function(client, bufnr)
    null_opts.on_attach(client, bufnr)
    ---
    -- you can add other stuff here....
    ---
  end,
  sources = {
    -- Replace these with the tools you have installed
    null_ls.builtins.formatting.prettierd,
    null_ls.builtins.diagnostics.eslint_d,
  }
})

-- vim.cmd [[autocmd BufWritePre * lua vim.lsp.buf.format()]]
