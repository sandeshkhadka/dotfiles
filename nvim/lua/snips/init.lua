local ls = require "luasnip"
local rep = require "luasnip.extras".rep
local s, i, t = ls.s, ls.insert_node, ls.text_node
local fmt = require "luasnip.extras.fmt".fmt

--lua

ls.add_snippets("lua", {
    s("snip",fmt('s("{}",fmt("{}",{{{}}})),',{i(1),i(2),i(3)})),
})

--html
ls.add_snippets("html", {
    s(".", fmt("<{} class = '{}'>{}</{}>", { i(1), i(2), i(3), rep(1) })),
})
ls.add_snippets("javascript",{
  s("cl",fmt("console.log({}){}",{i(1),i(2)})),
  s("eslintdnl",fmt("//eslint-disable-next-line",{})),
})
ls.add_snippets("javascriptreact",{
    s(".", fmt("<{} {}>{}</{}>", { i(1), i(2), i(3), rep(1) })),
})
ls.add_snippets("typescript",{
  s("cl",fmt("console.log({}){}",{i(1),i(2)})),
})
vim.keymap.set("n", "<leader><leader>s", ":source ~/.config/nvim/lua/snips/init.lua<CR>")
