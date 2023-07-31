local builtin = require("telescope.builtin")
vim.keymap.set("n", "<C-p>", builtin.find_files, { desc = "Telescope find files" })
vim.keymap.set("n", "<leader>km", builtin.keymaps, { desc = "List all keymaps" })
vim.keymap.set("n", "<leader>tgf", builtin.git_files, { desc = "Telescope git files" })
vim.keymap.set("n", "<leader>tb", builtin.builtin, { desc = "Telescope builtin" })
vim.keymap.set("n", "<leader>tld", builtin.diagnostics, { desc = "List all Diagnostic" })
vim.keymap.set("n", "<leader>tws", builtin.lsp_dynamic_workspace_symbols, { desc = "Workspace Symbols" })
vim.keymap.set("n", "<leader>tds", builtin.lsp_document_symbols, { desc = "Document Symbols" })
vim.keymap.set("n", "<leader>tlg", builtin.live_grep, { desc = "Live Grep" })
vim.keymap.set("n", "<leader>tlr", builtin.lsp_references, { desc = "LSP References" })
vim.keymap.set("n", "gd", builtin.lsp_definitions, { desc = "LSP Definitions" })

vim.keymap.set("n", "<leader>ps", function()
  builtin.grep_string({ search = vim.fn.input("Grep > ") })
end)
local actions = require("telescope.actions")
require("telescope").setup({
  defaults = {
    mappings = {
      i = {
        ["<M-i>"] = actions.close,
      },
    },
  },
})
