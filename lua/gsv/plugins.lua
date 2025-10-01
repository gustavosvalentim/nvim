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
    {
      "nvim-neo-tree/neo-tree.nvim",
      branch = "v3.x",
      dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        "MunifTanjim/nui.nvim",
      },
      init = function()
        vim.api.nvim_create_autocmd('BufEnter', {
          -- make a group to be able to delete it later
          group = vim.api.nvim_create_augroup('NeoTreeInit', {clear = true}),
          callback = function()
            local f = vim.fn.expand('%:p')
            if vim.fn.isdirectory(f) ~= 0 then
              vim.cmd('Neotree current dir=' .. f)
              -- neo-tree is loaded now, delete the init autocmd
              vim.api.nvim_clear_autocmds{group = 'NeoTreeInit'}
            end
          end
        })
      end,
      lazy = false,
      opts = {
        filesystem = {
          hijack_netrw_behavior = 'open_current'
        }
      },
    }
  },
  -- automatically check for plugin updates
  checker = { enabled = true, notify = false },
})
