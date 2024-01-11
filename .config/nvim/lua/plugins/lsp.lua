return {
	{
		"VonHeikemen/lsp-zero.nvim",
		dependencies = {
			"neovim/nvim-lspconfig",
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			"hrsh7th/nvim-cmp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"saadparwaiz1/cmp_luasnip",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-nvim-lua",
			"hrsh7th/cmp-cmdline",
			"L3MON4D3/LuaSnip",
			"rafamadriz/friendly-snippets",
			"github/copilot.vim",
			{ "roobert/tailwindcss-colorizer-cmp.nvim", config = true },
		},
		config = function()
			local lsp = require("lsp-zero")
			lsp.preset("recommended")

			local mason_tool_installer = require("mason-tool-installer")

			mason_tool_installer.setup({
				ensure_installed = {
					"prettier",
					"eslint_d",
					"pylint",
					"luacheck",
					"stylua",
					"black",
					"isort",

					"tsserver",
					-- "rust_analyzer",
					"gopls",
					"prismals",
					"terraformls",
					"lua_ls",
					"gofumpt",
				},
			})

			local cmp = require("cmp")
			local cmp_select = { behaviorr = cmp.SelectBehavior.Select }
			local cmp_mappings = lsp.defaults.cmp_mappings({
				["<CR>"] = cmp.mapping.confirm(cmp_select),
			})

			-- copilot
			cmp_mappings["<Tab>"] = nil
			cmp_mappings["<S-Tab>"] = nil
			cmp_mappings["<C-Space>"] = cmp.mapping.complete()

			lsp.setup_nvim_cmp({
				mapping = cmp_mappings,
				formatting = {
					format = require("tailwindcss-colorizer-cmp").formatter,
				},
			})

			lsp.on_attach(function(client, bufnr)
				local bufopts = { noremap = true, silent = true, buffer = bufnr }

				vim.keymap.set("n", "<leader>e", "<cmd>lua vim.diagnostic.open_float()<CR>", bufopts)
				vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
				vim.keymap.set("n", "gd", function()
					require("telescope.builtin").lsp_definitions({ reuse_win = true })
				end, bufopts)
				vim.keymap.set("n", "gf", "<Cmd>Telescope lsp_references<CR>", bufopts)
				vim.keymap.set("n", "gR", function()
					return ":IncRename " .. vim.fn.expand("<cword>")
				end, { expr = true })
				vim.keymap.set("n", "ga", vim.lsp.buf.code_action, bufopts)
			end)

			-- -- rust tools
			-- local rust_lsp = lsp.build_options("rust_analyzer", {
			-- 	settings = {
			-- 		["rust-analyzer"] = {
			-- 			cargo = {
			-- 				buildScripts = {
			-- 					enable = true,
			-- 				},
			-- 			},
			-- 			procMacro = {
			-- 				enable = true,
			-- 			},
			-- 			checkOnSave = {
			-- 				allFeatures = true,
			-- 				command = "clippy",
			-- 			},
			-- 		},
			-- 	},
			-- })

			-- cody/sg
			require("sg").setup({})

			-- -- Initialize rust_analyzer with rust-tools
			-- require("rust-tools").setup({
			-- 	server = rust_lsp,
			-- 	tools = {
			-- 		inlay_hints = {
			-- 			auto = true,
			-- 		},
			-- 	},
			-- })

			lsp.nvim_workspace()

			lsp.setup()

			vim.diagnostic.config({
				virtual_text = true,
			})
		end,
	},
	{
		"NvChad/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup({
				user_default_options = {
					tailwind = true,
				},
			})
		end,
	},
	{
		"mrcjkb/rustaceanvim",
		dependencies = {
			{
				"lvimuser/lsp-inlayhints.nvim",
				opts = {},
			},
		},
		version = "^3",
		ft = { "rust" },
		config = function()
			vim.g.rustaceanvim = {
				-- Plugin configuration
				tools = {
					code_actions = {
						use_telescope = true,
					},
				},
				-- LSP configuration
				server = {
					on_attach = function(client, bufnr)
						require("lsp-inlayhints").on_attach(client, bufnr)

						local bufnr = vim.api.nvim_get_current_buf()

						vim.keymap.set("n", "ga", function()
							vim.cmd.RustLsp("codeAction")
						end, { silent = true, buffer = bufnr })
					end,
					settings = {
						-- rust-analyzer language server configuration
						["rust-analyzer"] = {
							cargo = {
								buildScripts = {
									enable = true,
								},
							},
							procMacro = {
								enable = true,
							},
							checkOnSave = {
								allFeatures = true,
								command = "clippy",
							},
						},
					},
				},
				-- DAP configuration
				dap = {},
			}
		end,
	},
}
