return {
	"epwalsh/obsidian.nvim",
	version = "*", -- recommended, use latest release instead of latest commit
	lazy = true,
	-- ft = "markdown",
	-- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
	event = {
		-- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
		-- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/**.md"
		"BufReadPre "
			.. vim.fn.expand("~")
			.. "/vaults/personal/**.md",
		"BufNewFile " .. vim.fn.expand("~") .. "/vaults/personal/**.md",
		"BufReadPre " .. vim.fn.expand("~") .. "/vaults/personal/**/**.md",
		"BufNewFile " .. vim.fn.expand("~") .. "/vaults/personal/**/**.md",
		"BufReadPre " .. vim.fn.expand("~") .. "/vaults/wikis/**.md",
		"BufReadPre " .. vim.fn.expand("~") .. "/vaults/wikis/**/**.md",
		"BufNewFile " .. vim.fn.expand("~") .. "/vaults/wikis/**/**.md",
		"BufReadPre " .. vim.fn.expand("~") .. "/vaults/journal/**.md",
		"BufReadPre " .. vim.fn.expand("~") .. "/vaults/journal/**/**.md",
		"BufNewFile " .. vim.fn.expand("~") .. "/vaults/journal/**/**.md",
	},
	dependencies = {
		-- Required.
		"nvim-lua/plenary.nvim",

		-- see below for full list of optional dependencies 👇
	},
	config = function()
		require("obsidian").setup({
			workspaces = {
				{
					name = "personal",
					path = "~/vaults/personal",
				},
				{
					name = "wikis",
					path = "~/vaults/wikis",
					overrides = {
						disable_frontmatter = true,
					},
				},
				{
					name = "journal",
					path = "~/vaults/journal",
					overrides = {
						disable_frontmatter = true,
					},
				},
			},
			---@param url string
			follow_url_func = function(url)
				-- Open the URL in the default web browser.
				-- vim.fn.jobstart({ "open", url }) -- Mac OS
				vim.fn.jobstart({ "xdg-open", url }) -- linux
			end,

			---@param title string|?
			---@return string
			note_id_func = function(title)
				-- Create note IDs in a Zettelkasten format with a timestamp and a suffix.
				-- In this case a note with the title 'My new note' will be given an ID that looks
				-- like '1657296016-my-new-note', and therefore the file name '1657296016-my-new-note.md'
				local suffix = ""
				if title ~= nil then
					-- If title is given, transform it into valid file name.
					suffix = title
				else
					-- If title is nil, just add 4 random uppercase letters to the suffix.
					for _ = 1, 4 do
						suffix = suffix .. string.char(math.random(65, 90))
					end
				end
				return suffix
			end,

			-- Optional, customize how note file names are generated given the ID, target directory, and title.
			---@param spec { id: string, dir: obsidian.Path, title: string|? }
			---@return string|obsidian.Path The full path to the new note.
			note_path_func = function(spec)
				-- This is equivalent to the default behavior.
				local path
				print(spec.title)
				if spec.title ~= nil then
					path = spec.dir / tostring(spec.title)
				else
					path = spec.dir / tostring(spec.id)
				end
				return path:with_suffix(".md")
			end,
			disable_frontmatter = false,
		})
		local obsidianmaps = {
			{
				"n",
				"<C-p>",
				":ObsidianSearch<CR>",
			},
			{
				"n",
				"<C-l>",
				':lua require("obsidian.util").toggle_checkbox()<CR>',
			},
		}
		for i, kmap in pairs(obsidianmaps) do
			vim.api.nvim_set_keymap(kmap[1], kmap[2], kmap[3], { silent = true })
		end
	end,
}
