local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  -- My plugins here
  -- Is using a standard Neovim install, i.e. built from source or using a
  -- provided appimage.
  use 'lewis6991/impatient.nvim'
  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.0',
    -- or                            , branch = '0.1.x',
    requires = { { 'nvim-lua/plenary.nvim' } }
  }

  -- colorschemes
  use 'Mofiqul/dracula.nvim'
  use 'neanias/everforest-nvim'
  use({
    'rose-pine/neovim',
    as = 'rose-pine',
  })
  use { "catppuccin/nvim", as = "catppuccin" }
  use('morhetz/gruvbox')
  use('folke/tokyonight.nvim')

  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true }
  }



  use({ 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' })
  use('nvim-treesitter/playground')
  use('theprimeagen/harpoon')
  use('mbbill/undotree')
  use('tpope/vim-fugitive')
  use {
    "windwp/nvim-autopairs",
    config = function() require("nvim-autopairs").setup {} end
  }

  use('tpope/vim-surround')
  use {
    'VonHeikemen/lsp-zero.nvim',
    requires = {
      -- LSP Support
      { 'neovim/nvim-lspconfig' },
      { 'williamboman/mason.nvim' },
      { 'williamboman/mason-lspconfig.nvim' },

      -- Autocompletion
      { 'hrsh7th/nvim-cmp' },
      { 'hrsh7th/cmp-buffer' },
      { 'hrsh7th/cmp-path' },
      { 'saadparwaiz1/cmp_luasnip' },
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'hrsh7th/cmp-nvim-lua' },

      -- Snippets
      { 'L3MON4D3/LuaSnip' },
      { 'rafamadriz/friendly-snippets' },


      --null-ls
      { 'jose-elias-alvarez/null-ls.nvim' },
      { 'jay-babu/mason-null-ls.nvim' }
    }
  }
  -- Debuger
  -- use 'mfussenegger/nvim-dap'
  -- use "jay-babu/mason-nvim-dap.nvim"
  -- use { "rcarriga/nvim-dap-ui", requires = {"mfussenegger/nvim-dap"} }
  use {
    "rcarriga/nvim-dap-ui",
    dependencies = "mfussenegger/nvim-dap",
      }
  use {
    "mfussenegger/nvim-dap"
  }
  use "theHamsta/nvim-dap-virtual-text"
  use {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end
  }




  -- Unless you are still migrating, remove the deprecated commands from v1.x
  -- vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])
  -- use("stevearc/oil.nvim")
  use("nvim-tree/nvim-web-devicons")
  use("nvim-tree/nvim-tree.lua")
  -- use {
  --     "nvim-neo-tree/neo-tree.nvim",
  --     branch = "v2.x",
  --     requires = {
  --         "nvim-lua/plenary.nvim",
  --         , -- not strictly required, but recommended
  --         "MunifTanjim/nui.nvim",
  --     }
  -- }
  -- use("folke/zen-mode.nvim")
  use("github/copilot.vim")
  --   use {
  --   "zbirenbaum/copilot.lua",
  --   cmd = "Copilot",
  --   event = "InsertEnter",
  --   config = function()
  --     require("copilot").setup({})
  --   end,
  -- }
  -- Lua
  -- Lua
  use {
    'abecodes/tabout.nvim',
    config = function()
      require('tabout').setup {
        tabkey = '<Tab>',             -- key to trigger tabout, set to an empty string to disable
        backwards_tabkey = '<S-Tab>', -- key to trigger backwards tabout, set to an empty string to disable
        act_as_tab = true,            -- shift content if tab out is not possible
        act_as_shift_tab = false,     -- reverse shift content if tab out is not possible (if your keyboard/terminal supports <S-Tab>)
        default_tab = '<C-t>',        -- shift default action (only at the beginning of a line, otherwise <TAB> is used)
        default_shift_tab = '<C-d>',  -- reverse shift default action,
        enable_backwards = true,      -- well ...
        completion = true,            -- if the tabkey is used in a completion pum
        tabouts = {
          { open = "'", close = "'" },
          { open = '"', close = '"' },
          { open = '`', close = '`' },
          { open = '(', close = ')' },
          { open = '[', close = ']' },
          { open = '{', close = '}' }
        },
        ignore_beginning = true, --[[ if the cursor is at the beginning of a filled element it will rather tab out than shift the content ]]
        exclude = {} -- tabout will ignore these filetypes
      }
    end,
    wants = { 'nvim-treesitter' }, -- or require if not used so far
    after = { 'nvim-cmp' }         -- if a completion plugin is using tabs load it before
  }
  use("barrett-ruth/live-server.nvim")
  -- install without yarn or npm

  use({
    "iamcco/markdown-preview.nvim",
    run = "cd app && npm install",
    setup = function() vim.g.mkdp_filetypes = { "markdown" } end,
    ft = { "markdown" },
  })
  if packer_bootstrap then
    require('packer').sync()
  end
end)
