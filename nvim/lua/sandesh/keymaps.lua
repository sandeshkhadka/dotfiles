vim.g.mapleader = " "
-- vim.keymap.set("n", "<leader>eo", ":Lex<CR>")

vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
-- Fugitive
vim.keymap.set("n", "<leader>gs", vim.cmd.Git)

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("x", "<leader>p", [["_dP]])

vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

-- easy esacpe :)
vim.keymap.set({ "i", "v", "n", "x" }, "<C-c>", "<Esc>")

vim.keymap.set("n", "Q", "<nop>")
--vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)
vim.keymap.set("n", "<M-1>", ":tabn 1<CR>")
vim.keymap.set("n", "<M-2>", ":tabn 2<CR>")
vim.keymap.set("n", "<M-3>", ":tabn 3<CR>")
vim.keymap.set("n", "<M-4>", ":tabn 4<CR>")
vim.keymap.set("n", "<M-5>", ":tabn 5<CR>")
vim.keymap.set("n", "<M-6>", ":tabn 6<CR>")
vim.keymap.set("n", "<M-7>", ":tabn 7<CR>")
vim.keymap.set("n", "<M-8>", ":tabn 8<CR>")
--vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
--vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
--vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
--vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

-- vim.keymap.set({ "i", "v", "n", "x" }, "<M-h>", ":wincmd h<CR>")
-- vim.keymap.set({ "i", "v", "n", "x" }, "<M-j>", ":wincmd j<CR>")
-- vim.keymap.set({ "i", "v", "n", "x" }, "<M-k>", ":wincmd k<CR>")
-- vim.keymap.set({ "i", "v", "n", "x" }, "<M-l>", ":wincmd l<CR>")
