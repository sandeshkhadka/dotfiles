return {
  'lewis6991/impatient.nvim',
  'nvim-telescope/telescope-ui-select.nvim',
  {
    'nvim-lualine/lualine.nvim',
  },
  'mbbill/undotree',
  'tpope/vim-fugitive',
  {
    "windwp/nvim-autopairs",
    config = function() require("nvim-autopairs").setup {} end
  },
  'tpope/vim-surround',
    {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end
  },
}
