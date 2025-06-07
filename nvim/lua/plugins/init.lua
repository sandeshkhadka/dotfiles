return {
	"lewis6991/impatient.nvim",
	"nvim-telescope/telescope-ui-select.nvim",
	"nvim-lua/plenary.nvim",
	{
		"nvim-lualine/lualine.nvim",
	},
	"mbbill/undotree",
	"tpope/vim-fugitive",
	{
		"windwp/nvim-autopairs",
		config = function()
			require("nvim-autopairs").setup({})
		end,
	},
	"tpope/vim-surround",
	{
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup()
		end,
	},
	{
		"echasnovski/mini.bracketed",
		version = "*",
		config = function()
			require("mini.bracketed").setup()
		end,
	},
	{
		"echasnovski/mini.ai",
		version = "*",
		config = function()
			require("mini.ai").setup()
		end,
	},
	{
		"catgoose/nvim-colorizer.lua",
		event = "BufReadPre",
		opts = { -- set to setup table
		},
	},
}
