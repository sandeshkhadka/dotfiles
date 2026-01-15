-- lazy.nvim
return {
	"folke/snacks.nvim",
	opts = {
		styles = {
			snacks_image = {
				relative = "editor",
				col = -1,
			},
		},
		image = {
			disabled_ft = {
				"lua",
                "html",
                "jsx",
                "tsx",
                "js",
                "ts",
				-- Add any other file types here
			},
			math = {
				enabled = true,
				latex = {
					font_size = 40, -- Adjust the font size of the math
				},
			},
			doc = {
				-- enable image viewer for documents
				-- a treesitter parser must be available for the enabled languages.
				enabled = true,
				-- render the image inline in the buffer
				-- if your env doesn't support unicode placeholders, this will be disabled
				-- takes precedence over `opts.float` on supported terminals
				inline = false,
				-- render the image in a floating window
				-- only used if `opts.inline` is disabled
				float = true,
				max_width = 70,
				max_height = 70,
				-- Set to `true`, to conceal the image text when rendering inline.
				conceal = function(lang, type)
					-- only conceal math expressions
					return type == "math"
				end,
			},
			img_dirs = { "img", "images", "assets", "static", "public", "media", "attachments", "assets/imgs" },
		},
	},
}
