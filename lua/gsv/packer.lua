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

    use({ 'rose-pine/neovim', as = 'rose-pine' })

    use {
        '/home/gustavo/src/chtsh.nvim',
        requires = { 'nvim-lua/plenary.nvim' }
    }
end)
