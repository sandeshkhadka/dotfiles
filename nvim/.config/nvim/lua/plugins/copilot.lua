return {
	"zbirenbaum/copilot.lua",
	cmd = "Copilot",
	event = "InsertEnter",
	config = function()
		require("copilot").setup({
			panel = {
				enabled = true,
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
				enabled = true,
				-- enabled = false,
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
		vim.api.nvim_set_keymap(
			"n",
			"<leader>cp",
			':lua require("copilot.suggestion").toggle_auto_trigger()<CR>',
			{ noremap = true, silent = true }
		)
	end,
}
