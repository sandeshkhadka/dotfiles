return {
	dir = "~/projects/compile-mode.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		-- if you want to enable coloring of ANSI escape codes in
		-- compilation output, add:
		{ "m00qek/baleia.nvim", tag = "v1.3.0" },
	},
	config = function()
		---@type CompileModeOpts
		vim.g.compile_mode = {
			-- to add ANSI escape code support, add:
			baleia_setup = true,

			-- to make `:Compile` replace special characters (e.g. `%`) in
			-- the command (and behave more like `:!`), add:
			bang_expansion = true,

			default_command = "",

			ask_to_interrupt = false,

			---@type boolean
			input_word_completion = true,

			follow_output_window = true,
		}
		-- set keymap on normal mode for compile mode
		vim.keymap.set("n", "<leader>cc", ":Compile<CR>", { desc = "Compile" })
	end,
}
