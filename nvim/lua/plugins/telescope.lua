return {
	"nvim-telescope/telescope.nvim",
	version = "0.1.5",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		local builtin = require("telescope.builtin")
		vim.keymap.set("n", "<C-p>", builtin.find_files, { desc = "Telescope find files" })
		vim.keymap.set("n", "<leader>km", builtin.keymaps, { desc = "List all keymaps" })
		vim.keymap.set("n", "<leader>gf", builtin.git_files, { desc = "Telescope git files" })
		-- local actions = require("telescope.actions")
		require("telescope").setup({
			extensions = {
				["ui-select"] = {
					require("telescope.themes").get_dropdown({}),
				},
			},
			defaults = {
				mappings = {
					i = {
						-- ["<M-i>"] = actions.close,
					},
				},
			},
		})
		require("telescope").load_extension("ui-select")
	end,
}
