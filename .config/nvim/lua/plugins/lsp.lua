return {
	{
		"neovim/nvim-lspconfig",
		lazy = false,
		dependencies = {
			-- Mason
			"williamboman/mason.nvim",
			-- Mason lspconfig
			"williamboman/mason-lspconfig.nvim",
			-- Mason auto installer
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			-- Completion
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/nvim-cmp",
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
			-- Other
			"rafamadriz/friendly-snippets",
			"onsails/lspkind.nvim",
			"roobert/tailwindcss-colorizer-cmp.nvim",
		},

		config = function()
			local mason_tool_installer = require("mason-tool-installer")
			mason_tool_installer.setup({
				ensure_installed = {
					"prettier",
					"prettierd",
					"eslint-lsp",
					"pylint",
					"luacheck",
					"stylua",
					"black",
					"isort",

					"gopls",
					"golangci_lint_ls",
					"prismals",
					"terraformls",
					"lua_ls",
					"gofumpt",
					"buf",
					"checkmake",
				},
			})

			local cmp = require("cmp")
			local cmp_lsp = require("cmp_nvim_lsp")

			local capabilities = vim.tbl_deep_extend(
				"force",
				{},
				vim.lsp.protocol.make_client_capabilities(),
				cmp_lsp.default_capabilities()
			)

			require("mason").setup()
			require("mason-lspconfig").setup({
				handlers = {
					function(server_name)
						require("lspconfig")[server_name].setup({
							capabilities = capabilities,
						})
					end,
					-- ["rust_analyzer"] = function()
					--   local lspconfig = require("lspconfig")
					--   lspconfig.rust_analyzer.setup({
					--     capabilities = capabilities,
					--     settings = {
					--       ["rust-analyzer"] = {
					--         checkOnSave = {
					--           command = "clippy",
					--         },
					--       },
					--     },
					--   })
					-- end,
					["lua_ls"] = function()
						local lspconfig = require("lspconfig")
						lspconfig.lua_ls.setup({
							capabilities = capabilities,
							settings = {
								Lua = {
									diagnostics = {
										globals = { "vim" },
									},
								},
							},
						})
					end,
				},
			})

			cmp.setup({
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},
				completion = {
					completopt = "menu,menuone,noinsert",
				},
				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},
				mapping = cmp.mapping.preset.insert({
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),
					["<CR>"] = cmp.mapping.confirm({ select = true, behavior = cmp.ConfirmBehavior.Replace }),
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
				}, {
					{ name = "buffer" },
				}),
				formatting = {
					fields = {
						cmp.ItemField.Menu,
						cmp.ItemField.Abbr,
						cmp.ItemField.Kind,
					},
					format = require("lspkind").cmp_format({
						mode = "symbol_text",
						menu = {
							buffer = "[BUF]",
							nvim_lsp = "[LSP]",
							nvim_lua = "[LUA]",
							path = "[PATH]",
							luasnip = "[SNIP]",
						},
						before = require("tailwindcss-colorizer-cmp").formatter,
					}),
				},
			})

			require("luasnip.loaders.from_vscode").lazy_load()

			vim.diagnostic.config({
				title = false,
				underline = true,
				virtual_text = true,
				signs = true,
				update_in_insert = false,
				severity_sort = true,
				float = {
					source = "always",
					style = "minimal",
					border = "rounded",
					header = "",
					prefix = "",
				},
			})

			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("tb-lsp-attach", { clear = true }),
				callback = function(event)
					local bufopts = { noremap = true, silent = true, buffer = bufnr }

					local client = vim.lsp.get_client_by_id(event.data.client_id)
					if client == nil then
						print("client is nil")
						return
					end

					-- do not setup bindings for copilot
					if client.name == "copilot" then
						return
					end

					vim.keymap.set("n", "<leader>e", "<cmd>lua vim.diagnostic.open_float()<CR>", bufopts)
					vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
					vim.keymap.set("n", "gd", function()
						-- require("telescope.builtin").lsp_definitions({ reuse_win = true })
						require("fzf-lua").lsp_definitions({})
					end, bufopts)
					vim.keymap.set("n", "gf", "<Cmd>Telescope lsp_references<CR>", bufopts)
					vim.keymap.set("n", "gR", function()
						return ":IncRename " .. vim.fn.expand("<cword>")
					end, { expr = true })

					if client.name == "rust-analyzer" or client.name == "rust_analyzer" then
						-- custom code actions for rust
						vim.keymap.set("n", "ga", function()
							vim.cmd.RustLsp("codeAction")
						end, bufopts)
					else
						vim.keymap.set("n", "ga", vim.lsp.buf.code_action, bufopts)
					end

					-- highlight
					if client and client.server_capabilities.documentHighlightProvider then
						vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
							buffer = event.buf,
							callback = vim.lsp.buf.document_highlight,
						})

						vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
							buffer = event.buf,
							callback = vim.lsp.buf.clear_references,
						})
					end
				end,
			})
		end,
	},
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",
		enabled = false,
		config = function()
			require("copilot").setup({
				panel = {
					enabled = false,
				},
				suggestion = {
					enabled = true,
					auto_trigger = true,
					keymap = {
						-- accept = "<Tab>",
						accept = false,
					},
				},
			})

			vim.keymap.set("i", "<Tab>", function()
				if require("copilot.suggestion").is_visible() then
					require("copilot.suggestion").accept()
				else
					vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Tab>", true, false, true), "n", false)
				end
			end, { desc = "Super Tab" })
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
		version = "^4",
		ft = { "rust" },
		config = function()
			vim.g.rustaceanvim = {
				-- Plugin configuration
				tools = {
					code_actions = {
						-- use_telescope = true,
					},
				},
				-- LSP configuration
				server = {
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
								ignored = {
									leptos_macro = {
										"server",
									},
								},
							},
							checkOnSave = {
								allFeatures = true,
								command = "clippy",
							},
							-- rustfmt = {
							-- 	overrideCommand = { "leptosfmt", "--stdin", "--rustfmt" },
							-- },
						},
					},
				},
				-- DAP configuration
				dap = {},
			}
		end,
	},
}
