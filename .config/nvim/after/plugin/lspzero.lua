local lsp = require('lsp-zero')
-- lsp.preset('recommended')
lsp.preset('lsp-compe')

lsp.setup()

local status, saga = pcall(require, "lspsaga")
if (not status) then return end

saga.init_lsp_saga {
    code_action_lightbulb = {
        enable = false
    }
}

lsp.ensure_installed({
    'tsserver',
    'eslint',
    'sumneko_lua',
    'rust_analyzer',
    'gopls'
  })


  lsp.nvim_workspace()

lsp.setup()


local cmp = require("cmp")

local cmp_mappings = lsp.defaults.cmp_mappings({

})

cmp_mappings["<Tab>"] = nil
cmp_mappings["<S-Tab>"] = nil


local cmp_config = lsp.defaults.cmp_config({
  sources = {
    { name = "luasnip", priority = 100 },
    { name = "nvim_lsp", priority = 90 },
    { name = "nvim_lsp_signature_help" },
    { name = "nvim_lua", priority = 90 },
    { name = "copilot", priority = 80 },
    { name = "path", priority = 5 },
  },
  mappings = cmp_mappings,
})

cmp.setup(cmp_config)
cmp.setup.cmdline(":", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = "path" },
  }, {
    {
      name = "cmdline",
      option = {
        ignore_cmds = { "Man", "!" },
      },
    },
  }),
})
cmp.setup.cmdline("/", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = "buffer" },
  },
})

lsp.on_attach(function(client, bufnr)
    local bufopts = { noremap=true, silent=true, buffer=bufnr }

	vim.keymap.set("n", "<leader>e", "<cmd>lua vim.diagnostic.open_float()<CR>", bufopts)
    vim.keymap.set('n', 'K', '<Cmd>Lspsaga hover_doc<CR>', bufopts)
    vim.keymap.set('n', 'gd', '<Cmd>Lspsaga lsp_finder<CR>', bufopts)
    vim.keymap.set('n', 'gR', '<Cmd>Lspsaga rename<CR>', bufopts)
    vim.keymap.set('n', 'gc', '<Cmd>Lspsaga code_action<CR>', bufopts)
end)

vim.cmd [[autocmd BufWritePre * lua vim.lsp.buf.formatting_sync()]]
