return {
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		dependencies = {
			{ "zbirenbaum/copilot.lua" }, -- or zbirenbaum/copilot.lua
			{ "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async functions
		},
		build = "make tiktoken", -- Only on MacOS or Linux
		opts = {
			-- See Configuration section for options
		},
		config = function()
			local chat = require("CopilotChat")
			local select = require("CopilotChat.select")
			local copilot = require("copilot")
			chat.setup({
				model = "claude-3.7-sonnet",
				-- chat_autocomplete = false,
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
			-- vim.key
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
