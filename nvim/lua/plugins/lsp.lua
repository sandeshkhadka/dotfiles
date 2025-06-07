return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"folke/neodev.nvim",

			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",

			{ "j-hui/fidget.nvim", opts = {} },

			-- Autoformatting
			"stevearc/conform.nvim",

			-- Schema information
			"b0o/SchemaStore.nvim",
			"https://git.sr.ht/~p00f/clangd_extensions.nvim",
		},
		config = function()
			require("neodev").setup({})

			local capabilities = nil
			if pcall(require, "cmp_nvim_lsp") then
				capabilities = require("cmp_nvim_lsp").default_capabilities()
			end

			local lspconfig = require("lspconfig")

			local servers = {
				bashls = true,
				lua_ls = {
					server_capabilities = {
						semanticTokensProvider = vim.NIL,
					},
				},
				cssls = true,
				-- Probably want to disable formatting for this lang server
				-- tsserver = {
				-- 	server_capabilities = {
				-- 		documentFormattingProvider = false,
				-- 	},
				-- },
				jsonls = {
					settings = {
						json = {
							schemas = require("schemastore").json.schemas(),
							validate = { enable = true },
						},
					},
				},

				yamlls = {
					settings = {
						yaml = {
							schemaStore = {
								enable = false,
								url = "",
							},
							schemas = require("schemastore").yaml.schemas(),
						},
					},
				},

				clangd = {
					filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
				},
				-- clangd = true,
				tailwindcss = true,
				cssmodules_ls = true,
				pyright = true,
				eslint = true,
				-- bufls = true,
				-- pbls = true,
				cmake = true,
				rust_analyzer = true,
				gopls = true,
			}
			local servers_to_install = vim.tbl_filter(function(key)
				local t = servers[key]
				if type(t) == "table" then
					return not t.manual_install
				else
					return t
				end
			end, vim.tbl_keys(servers))

			require("mason").setup()
			local ensure_installed = {
				"stylua",
				"lua_ls",
				"clangd",
				"bashls",
				"bash-language-server",
			}

			vim.list_extend(ensure_installed, servers_to_install)
			require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

			for name, config in pairs(servers) do
				if config == true then
					config = {}
				end
				config = vim.tbl_deep_extend("force", {}, {
					capabilities = capabilities,
				}, config)

				lspconfig[name].setup(config)
			end

			local disable_semantic_tokens = {
				lua = true,
			}

			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(args)
					local bufnr = args.buf
					local client = assert(vim.lsp.get_client_by_id(args.data.client_id), "must have valid client")

					local settings = servers[client.name]
					if type(settings) ~= "table" then
						settings = {}
					end

					local builtin = require("telescope.builtin")

					vim.opt_local.omnifunc = "v:lua.vim.lsp.omnifunc"
					vim.keymap.set("n", "gd", builtin.lsp_definitions, { buffer = 0 })
					vim.keymap.set("n", "gr", builtin.lsp_references, { buffer = 0 })
					vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = 0 })
					vim.keymap.set("n", "gT", vim.lsp.buf.type_definition, { buffer = 0 })
					vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = 0 })
					vim.keymap.set("n", "<leader>ws", vim.lsp.buf.workspace_symbol, { buffer = 0 })
					vim.keymap.set("n", "gl", vim.diagnostic.open_float, { buffer = 0 })
					vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { buffer = 0 })
					vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, { buffer = 0 })
					vim.keymap.set("n", "<M-p>", builtin.builtin, { desc = "Telescope builtin" })
					vim.keymap.set("n", "<leader>ld", builtin.diagnostics, { desc = "List all Diagnostic" })
					vim.keymap.set(
						"n",
						"<leader>ws",
						builtin.lsp_dynamic_workspace_symbols,
						{ desc = "Workspace Symbols" }
					)
					vim.keymap.set("n", "<leader>ds", builtin.lsp_document_symbols, { desc = "Document Symbols" })
					vim.keymap.set("n", "<leader>lg", builtin.live_grep, { desc = "Live Grep" })
					vim.keymap.set("n", "<leader>lr", builtin.lsp_references, { desc = "LSP References" })
					vim.keymap.set("n", "<leader>la", vim.lsp.buf.code_action, { desc = "LSP Code Action" })

					local filetype = vim.bo[bufnr].filetype
					if disable_semantic_tokens[filetype] then
						client.server_capabilities.semanticTokensProvider = nil
					end

					-- Override server capabilities
					if settings.server_capabilities then
						for k, v in pairs(settings.server_capabilities) do
							if v == vim.NIL then
								---@diagnostic disable-next-line: cast-local-type
								v = nil
							end

							client.server_capabilities[k] = v
						end
					end
				end,
			})

			-- Autoformatting Setup
			require("conform").setup({
				formatters_by_ft = {
					lua = { "stylua" },
					python = { "isort", "black" },
					-- Use a sub-list to run only the first available formatter
					javascript = { "prettierd" },
					-- cpp = { "clang-format" },
					c = { "clang-format" },
				},
			})

			vim.api.nvim_create_autocmd("BufWritePre", {
				callback = function(args)
					require("conform").format({
						bufnr = args.buf,
						lsp_fallback = false,
						quiet = true,
					})
				end,
			})
			require("fidget").setup({
				notification = {
					window = {
						normal_hl = "Comment", -- Base highlight group in the notification window
						winblend = 0, -- Background color opacity in the notification window
						border = "none", -- Border around the notification window
						zindex = 45, -- Stacking priority of the notification window
						max_width = 0, -- Maximum width of the notification window
						max_height = 0, -- Maximum height of the notification window
						x_padding = 1, -- Padding from right edge of window boundary
						y_padding = 0, -- Padding from bottom edge of window boundary
						align = "bottom", -- How to align the notification window
						relative = "editor", -- What the notification window position is relative to
					},
				},
			})
		end,
	},
}
