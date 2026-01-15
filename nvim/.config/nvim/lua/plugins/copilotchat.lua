return {
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		lazy = true,
		cmd = {
			"CopilotChat",
			"CopilotChatOpen",
			"CopilotChatToggle",
		},
		keys = {
			{ "<leader>aa", mode = { "n", "v" } },
			{ "<leader>ax", mode = "n" },
			{ "<leader>as", mode = "n" },
			{ "<leader>am", mode = "n" },
			{ "<leader>ap", mode = { "n", "v" } },
			{ "<leader>aq", mode = { "n", "v" } },
			{ "<leader>ae", mode = "n" },
			{ "<leader>ar", mode = "n" },
			{ "<leader>at", mode = "n" },
			{ "<leader>af", mode = "n" },
			{ "<leader>ao", mode = "n" },
			{ "<leader>ad", mode = "n" },
			{ "<leader>ac", mode = "n" },
			{ "<leader>cp", mode = "n" },
		},
		dependencies = {
			{
				"zbirenbaum/copilot.lua",
				lazy = true,
			},
			{ "nvim-lua/plenary.nvim", branch = "master" },
		},
		build = "make tiktoken",
		config = function()
			local chat = require("CopilotChat")
			local select = require("CopilotChat.select")
			local copilot = require("copilot")
			chat.setup({
				model = "claude-sonnet-4.5",
				-- chat_autocomplete = false,
				selection = select.buffer, -- Add this line to always include current buffer
				window = {
					layout = "vertical", -- 'vertical', 'horizontal', 'float', 'replace', or a function that returns the layout
					width = 0.5, -- fractional width of parent, or absolute width in columns when > 1
					height = 0.5, -- fractional height of parent, or absolute height in rows when > 1
					-- Options below only apply to floating windows
					relative = "editor", -- 'editor', 'win', 'cursor', 'mouse'
					border = "single", -- 'none', single', 'double', 'rounded', 'solid', 'shadow'
					row = nil, -- row position of the window, default is centered
					col = nil, -- column position of the window, default is centered
					title = "Copilot Chat", -- title of chat window
					footer = nil, -- footer of chat window
					zindex = 1, -- determines if window is on top or below other floating windows
				},
				prompts = {
					Explain = {
						mapping = "<leader>ae",
						description = "AI Explain",
					},
					Review = {
						mapping = "<leader>ar",
						description = "AI Review",
					},
					Tests = {
						mapping = "<leader>at",
						description = "AI Tests",
					},
					Fix = {
						mapping = "<leader>af",
						description = "AI Fix",
					},
					Optimize = {
						mapping = "<leader>ao",
						description = "AI Optimize",
					},
					Docs = {
						mapping = "<leader>ad",
						description = "AI Documentation",
					},
					Commit = {
						mapping = "<leader>ac",
						description = "AI Generate Commit",
						selection = select.buffer,
					},
				},

				mappings = {
					close = {
						normal = "q",
						insert = "",
					},
					reset = false,
					yank_diff = {
						normal = "gy",
						register = '"', -- Default register to use for yanking
					},
					show_diff = {
						normal = "gd",
						full_diff = true, -- Show full diff instead of unified diff when showing diff window
					},
					accept_diff = {
						normal = "<C-y>",
						insert = "<C-y>",
					},
				},
			})
			copilot.setup({
				panel = {
					enabled = false,
					-- enabled = true,
					auto_refresh = true,
					keymap = {
						jump_prev = "[[",
						jump_next = "]]",
						accept = "<C-y>",
						refresh = "gr",
						open = "<M-CR>",
					},
					layout = {
						position = "bottom", -- | top | left | right
						ratio = 0.4,
					},
				},
				suggestion = {
					-- enabled = true,
					enabled = false,
					auto_trigger = false,
					-- auto_trigger = true,
					debounce = 75,
					keymap = {
						accept = "<M-y>",
						accept_word = false,
						accept_line = "<C-l>",
						next = "<M-]>",
						prev = "<M-[>",
						dismiss = "<C-]>",
					},
				},
				filetypes = {
					-- yaml = true,
					-- markdown = true,
					-- help = false,
					-- gitcommit = false,
					-- gitrebase = false,
					-- hgcommit = false,
					-- svn = false,
					-- cvs = false,
					-- ["."] = false,
				},
				copilot_node_command = "node", -- Node.js version must be > 16.x
				server_opts_overrides = {},
			})
			-- vim.key

			vim.api.nvim_set_keymap(
				"n",
				"<leader>cp",
				':lua require("copilot.suggestion").toggle_auto_trigger()<CR>',
				{ noremap = true, silent = true }
			)
			vim.keymap.set({ "n" }, "<leader>aa", chat.toggle, { desc = "AI Toggle" })
			vim.keymap.set({ "v" }, "<leader>aa", chat.open, { desc = "AI Open" })
			vim.keymap.set({ "n" }, "<leader>ax", chat.reset, { desc = "AI Reset" })
			vim.keymap.set({ "n" }, "<leader>as", chat.stop, { desc = "AI Stop" })
			vim.keymap.set({ "n" }, "<leader>am", chat.select_model, { desc = "AI Models" })
			vim.keymap.set({ "n", "v" }, "<leader>ap", chat.select_prompt, { desc = "AI Prompts" })
			vim.keymap.set({ "n", "v" }, "<leader>aq", function()
				vim.ui.input({
					prompt = "AI Question> ",
				}, function(input)
					if input ~= "" then
						chat.ask(input)
					end
				end)
			end, { desc = "AI Question" })
		end,
	},
}
