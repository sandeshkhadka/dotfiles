return {
  "obsidian-nvim/obsidian.nvim",
  version = "*", -- recommended, use latest release instead of latest commit
  ft = "markdown",
  -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
  event = {
    -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
    -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
    -- refer to `:h file-pattern` for more examples
    "BufReadPre /home/pqr/Sync/singularity/*.md",
    "BufNewFile /home/pqr/Sync/singularity/*.md",
  },
  ---@module 'obsidian'
  ---@type obsidian.config
  opts = {
    legacy_commands = false, -- this will be removed in the next major release
    preferred_link_style = "markdown",
    workspaces = {
      {
        name = "singularity",
        path = "~/Sync/singularity",
      },
    },

    ui = {
      enable = false,
    },
    attachments = {
      img_name_func = function()
        return ""
      end,
      img_folder = "assets/imgs",
      confirm_img_paste = true,
      img_text_func = function(path)
        local name = vim.fs.basename(tostring(path))

        name = require("obsidian.util").urlencode(name)

        return string.format("![%s](%s)", name, name)
      end

    },
    footer = nil,
    note_id_func = function(title, _)
      local id = ""
      if title ~= nil then
        id = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
      else
        for _ = 1, 4 do
          id = id .. string.char(math.random(65, 90))
        end
      end
      return id
    end,

    callbacks = {
      enter_note = function(note)
        vim.keymap.set("n", "<leader>lg", "<cmd>Obsidian search<cr>", {
          buffer = note.bufnr,
          desc = "Toggle obsidian search",
        })
        vim.keymap.set("n", "<C-p>", "<cmd>Obsidian quick_switch<cr>", {
          buffer = note.bufnr,
          desc = "Obsidian switch",
        })

        vim.keymap.set("n","<leader>oo", "<cmd>Obsidian open<cr>", {
          buffer = note.bufnr,
          desc = "Open in obsidian app",
        })
        vim.keymap.set("n", "<M-p>", "<cmd>ObsidianBridgePickCommand<cr>", {
          buffer = note.bufnr,
          desc = "Toggle Obsidian Pick Command",
        })
        vim.keymap.set("n", "<leader>ot", "<cmd>Obsidian tags<cr>", {
          buffer = note.bufnr,
          desc = "Obsidian tags",
        })
        vim.keymap.set("n", "<leader>op", "<cmd>Obsidian paste_img<cr>", {
          buffer = note.bufnr,
          desc = "Toggle Obsidian Pick Command",
        })

        vim.keymap.set("n", "<leader>ob", "<cmd>Obsidian backlinks<cr>", {
          buffer = note.bufnr,
          desc = "Obsidian backlinks",
        })
        vim.keymap.set("n", "<leader>ol", "<cmd>Obsidian links<cr>", {
          buffer = note.bufnr,
          desc = "Obsidian-links",
        })
        vim.keymap.set("n", "<leader>oc", "<cmd>Obsidian toc<cr>", {
          buffer = note.bufnr,
          desc = "Obsidian toc",
        })
      end,
    },
  },
}
