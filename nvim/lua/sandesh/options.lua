vim.opt.guicursor = ""

vim.opt.rnu = true
vim.opt.conceallevel = 2
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = true

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.opt.tw = 110

vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
vim.api.nvim_set_hl(0, "TelescopeNormal", { bg = "none" })
vim.api.nvim_set_hl(0, "TelescopeBorder", { bg = "none" })

vim.g.netrw_banner = 0

-- folding
vim.opt.fillchars = { fold = " " }
vim.opt.foldmethod = "indent"
vim.opt.foldenable = false
vim.opt.foldlevel = 99

vim.cmd([[
  function! CustomFoldText()
    let line = getline(v:foldstart)
    let indent = matchstr(line, '^\s*')
    let num_lines = v:foldend - v:foldstart + 1
    " return indent .. '-- folded ' .. num_lines .. ' lines --'
    return indent .. "..."
  endfunction

  set foldtext=CustomFoldText()
]])

-- g.markdown_folding = 1 -- enable markdown folding
