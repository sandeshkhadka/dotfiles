return {
  {
    'L3MON4D3/LuaSnip',
    config = function()
      if not pcall(require, "luasnip") then
        return
      end

      local ls    = require "luasnip"
      local types = require "luasnip.util.types"
      local rep   = require "luasnip.extras".rep
      local s, i  = ls.s, ls.insert_node
      local fmt   = require "luasnip.extras.fmt".fmt

      require("luasnip/loaders/from_vscode").lazy_load()
      ls.config.set_config {
        -- This tells LuaSnip to remember to keep around the last snippet.
        -- You can jump back into it even if you move outside of the selection
        history = true,

        -- This one is cool cause if you have dynamic snippets, it updates as you type!
        updateevents = "TextChanged,TextChangedI",

        -- Autosnippets:
        enable_autosnippets = true,

        -- Crazy highlights!!
        -- #vid3
        -- ext_opts = nil,
        ext_opts = {
          [types.choiceNode] = {
            active = {
              virt_text = { { " « ", "NonTest" } },
            },
          },
        },
      }

      -- <c-k> is my expansion key
      -- this will expand the current item or jump to the next item within the snippet.
      vim.keymap.set({ "i", "s" }, "<c-k>", function()
        if ls.jumpable() then
          ls.jump(1)
        end
      end, { silent = true })

      vim.keymap.set({ "i", "s" }, "<c-l>", function()
        if ls.expandable() then
          ls.expand()
        end
      end, { silent = true })

      -- <c-j> is my jump backwards key.
      -- this always moves to the previous item within the snippet
      vim.keymap.set({ "i", "s" }, "<c-j>", function()
        if ls.jumpable(-1) then
          ls.jump(-1)
        end
      end, { silent = true })

      -- <c-l> is selecting within a list of options.
      -- This is useful for choice nodes (introduced in the forthcoming episode 2)
      vim.keymap.set("i", "<c-;>", function()
        if ls.choice_active() then
          ls.change_choice(1)
        end
      end)
      ls.filetype_extend("javascriptreact", { "javascript", "html" })
      ls.filetype_extend("typescriptreact", { "javascriptreact", "html" })


      ls.add_snippets("lua", {
        s("snip", fmt('s("{}",fmt("{}",{{{}}})),', { i(1), i(2), i(3) })),
      })

      --html
      ls.add_snippets("html", {
        s(".", fmt("<{} class = '{}'>{}</{}>", { i(1), i(2), i(3), rep(1) })),
      })
      ls.add_snippets("javascript", {
        s("cl", fmt("console.log({}){}", { i(1), i(2) })),
        s("eslintdnl", fmt("//eslint-disable-next-line", {})),
      })
      ls.add_snippets("javascriptreact", {
        s(".", fmt("<{} {}>{}</{}>", { i(1), i(2), i(3), rep(1) })),
      })
      ls.add_snippets("typescript", {
        s("cl", fmt("console.log({}){}", { i(1), i(2) })),
      })
    end
  },
  { 'rafamadriz/friendly-snippets' },
}
