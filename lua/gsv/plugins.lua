-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system({ 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { 'Failed to clone lazy.nvim:\n', 'ErrorMsg' },
      { out, 'WarningMsg' },
      { '\nPress any key to exit...' },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim
require('lazy').setup({
  spec = {
    -- import your plugins
    { 'nvim-tree/nvim-web-devicons', lazy = true },
    {
        'Mofiqul/dracula.nvim',
        config = function()
            vim.cmd([[colorscheme dracula]])
        end
    },
    {
        'nvim-treesitter/nvim-treesitter',
        config = function()
            vim.cmd([[TSUpdate]])
        end
    },
    { 'neovim/nvim-lspconfig' },
    { 'williamboman/mason.nvim' },
    { 'williamboman/mason-lspconfig.nvim' },
    { 'hrsh7th/nvim-cmp' },
    { 'hrsh7th/cmp-nvim-lsp' },
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' }
    },
    { 'tpope/vim-fugitive' },
    { 'junegunn/fzf' },
    { 'junegunn/fzf.vim' },
  },
  -- automatically check for plugin updates
  checker = { enabled = true, notify = false },
})
