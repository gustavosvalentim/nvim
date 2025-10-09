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
        "rose-pine/neovim",
        name = "rose-pine",
        config = function()
            require('rose-pine').setup({
                styles = {
                    transparency = true,
                }
            })
            vim.cmd([[colorscheme rose-pine]])
        end
    },
    {
        'nvim-treesitter/nvim-treesitter',
        config = function()
            vim.cmd([[TSUpdate]])
        end
    },
    { 'neovim/nvim-lspconfig' },
    { 'mason-org/mason.nvim', opts = {} },
    { 'mason-org/mason-lspconfig.nvim',
      opts = {
        ensure_installed = { 'lua_ls', 'gopls', 'rust_analyzer', 'basedpyright', 'ts_ls' },
      },
      dependencies = {
        { 'mason-org/mason.nvim', opts = {} },
        { 'neovim/nvim-lspconfig' },
      },
    },
    { 'hrsh7th/nvim-cmp' },
    { 'hrsh7th/cmp-nvim-lsp' },
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' }
    },
    { 'tpope/vim-fugitive' },
    {
      "ibhagwan/fzf-lua",
      dependencies = { "nvim-tree/nvim-web-devicons" },
      opts = {}
    },
    { 'lewis6991/gitsigns.nvim' },
    {
      "nvim-neo-tree/neo-tree.nvim",
      branch = "v3.x",
      dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        "MunifTanjim/nui.nvim",
      },
      lazy = false,
      config = function()
        require'neo-tree'.setup {
          close_if_last_window = true,
          hide_gitignored = true,
          hide_by_pattern = {
            '*/node_modules',
            '*/.venv',
          },
          opts = {
            filesystem = {
              hijack_netrw_behavior = 'open_current'
            }
          },
        }
      end
    },
    --{
    --    'goolord/alpha-nvim',
    --    dependencies = { 'nvim-tree/nvim-web-devicons' },
    --    config = function ()
    --        local theme = require'alpha.themes.dashboard'

    --        theme.file_icons.provider = "devicons"

    --        require'alpha'.setup(theme.config)
    --    end
    --};
  },
  -- automatically check for plugin updates
  checker = { enabled = true, notify = false },
})
