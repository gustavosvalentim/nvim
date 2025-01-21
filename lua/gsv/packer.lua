vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
	use 'wbthomason/packer.nvim'

    use 'tpope/vim-fugitive'

    use "nvim-lua/plenary.nvim"

    use "MunifTanjim/nui.nvim"

	use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }

	use {
	  'nvim-telescope/telescope.nvim', tag = '0.1.1',
	  requires = { {'nvim-lua/plenary.nvim'} }
	}

	use 'ray-x/go.nvim'
	use 'ray-x/guihua.lua' -- recommended if need floating window support
	use 'neovim/nvim-lspconfig'

    use 'mfussenegger/nvim-dap'
    use { "rcarriga/nvim-dap-ui", requires = {"mfussenegger/nvim-dap"} }
    use 'leoluz/nvim-dap-go'

    use 'projekt0n/github-nvim-theme'

    use 'hrsh7th/nvim-cmp' -- Autocompletion plugin
    use 'hrsh7th/cmp-nvim-lsp' -- LSP source for nvim-cmp

    use {
      'nvim-lualine/lualine.nvim',
      requires = { 'nvim-tree/nvim-web-devicons', opt = true }
    }

    use {
      "smjonas/inc-rename.nvim",
      config = function()
        require("inc_rename").setup()
      end,
    }

    -- use {
    --   "folke/noice.nvim",
    --   requires = { "MunifTanjim/nui.nvim" }
    -- }

    use({
      "utilyre/barbecue.nvim",
      tag = "*",
      requires = {
        "SmiteshP/nvim-navic",
        "nvim-tree/nvim-web-devicons", -- optional dependency
      },
      config = function()
        require("barbecue").setup()
      end,
    })
end)
