return {
  {
    "nvimtools/none-ls.nvim",
    config = function()
      local null_ls = require("null-ls")

      -- local augroup = vim.api.nvim_create_augroup("Format", {})

      null_ls.setup({
        sources = {
          -- FORMATTING
          null_ls.builtins.formatting.stylua,
          null_ls.builtins.formatting.prettierd,
          null_ls.builtins.formatting.gofumpt,

          -- DIAGNOSTICS
          null_ls.builtins.diagnostics.eslint_d,
          null_ls.builtins.diagnostics.buf,
          null_ls.builtins.diagnostics.checkmake,
          null_ls.builtins.diagnostics.golangci_lint,

          -- CODE ACTIONS
          null_ls.builtins.code_actions.eslint_d,
        },

        -- on_attach = function(client, bufnr)
        -- 	if client.supports_method("textDocument/formatting") then
        -- 		vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
        -- 		vim.api.nvim_create_autocmd("BufWritePre", {
        -- 			group = augroup,
        -- 			buffer = bufnr,
        -- 			callback = function()
        -- 				vim.lsp.buf.format({ async = false })
        -- 			end,
        -- 		})
        -- 	end
        -- end,
      })
    end,
  },
}
