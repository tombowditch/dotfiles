return {
	{
		"saghen/blink.cmp",
		lazy = false,
		dependencies = "rafamadriz/friendly-snippets",
		version = "v0.*",

		---@module 'blink.cmp'
		---@type blink.cmp.Config
		opts = {
			keymap = { preset = "enter" },
			highlight = {
				use_nvim_cmp_as_default = true,
			},
			nerd_font_variant = "mono",
			accept = { auto_brackets = { enabled = true } },
			trigger = { signature_help = { enabled = true } },
		},
	},
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
			"L3MON4D3/LuaSnip",
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

			local capabilities = vim.tbl_deep_extend("force", {}, vim.lsp.protocol.make_client_capabilities())

			capabilities = require("blink.cmp").get_lsp_capabilities(capabilities)

			require("mason").setup()
			require("mason-lspconfig").setup({
				handlers = {
					function(server_name)
						require("lspconfig")[server_name].setup({
							capabilities = capabilities,
						})
					end,
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
					local bufopts = { noremap = true, silent = true, buffer = event.buf }

					local client = vim.lsp.get_client_by_id(event.data.client_id)
					if client == nil then
						print("client is nil")
						return
					end

					-- do not setup bindings for copilot
					if client.name == "copilot" then
						return
					end

					if client.server_capabilities.inlayHintProvider then
						vim.g.inlay_hints_visible = true
						vim.lsp.inlay_hint.enable(true, { bufnr = event.buf })
					else
						print("no inlay hints available")
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
