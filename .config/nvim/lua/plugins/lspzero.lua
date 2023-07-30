return {
  {
    "VonHeikemen/lsp-zero.nvim",
    dependencies = {
      "neovim/nvim-lspconfig",
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/nvim-cmp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-cmdline",
      "L3MON4D3/LuaSnip",
      "rafamadriz/friendly-snippets"
    },
    config = function()
      local lsp = require('lsp-zero')
      lsp.preset('recommended')

      lsp.ensure_installed({
        'tsserver',
        'eslint',
        'rust_analyzer',
        'gopls',
        'prismals',
        'terraformls',
        'lua_ls'
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
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
        vim.keymap.set('n', 'gd', function() require("telescope.builtin").lsp_definitions({ reuse_win = true }) end,
          bufopts)
        vim.keymap.set('n', 'gf', '<Cmd>Telescope lsp_references<CR>', bufopts)
        vim.keymap.set("n", "gR", function()
          return ":IncRename " .. vim.fn.expand("<cword>")
        end, { expr = true })
        vim.keymap.set('n', 'gc', vim.lsp.buf.code_action, bufopts)
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
          ["terraformls"] = { "terraform", "tf" },
          ["lua_ls"] = { "lua" }
        }
      })

      lsp.nvim_workspace()

      lsp.setup()

      vim.diagnostic.config({
        virtual_text = false,
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
    end
  },
}
