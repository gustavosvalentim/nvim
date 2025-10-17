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
      'tanvirtin/monokai.nvim',
      config = function ()
        require('monokai').setup{}
        vim.cmd([[set t_Co=256]])
        vim.cmd([[colorscheme monokai]])
        vim.o.termguicolors = true
        vim.api.nvim_set_hl(0, "Normal", { bg = "#1F1F1F" })
      end
    },
    -- {
    --     "rose-pine/neovim",
    --     name = "rose-pine",
    --     config = function()
    --       require('rose-pine').setup{
    --         styles = {
    --             transparency = false,
    --         }
    --       }
    --       vim.cmd([[colorscheme rose-pine]])
    --     end
    -- },
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
        ensure_installed = { 'lua_ls', 'gopls', 'rust_analyzer', 'basedpyright', 'ts_ls', 'emmet_language_server' },
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
      "olrtg/nvim-emmet",
      config = function()
        vim.keymap.set({ "n", "v" }, '<leader>xe', require('nvim-emmet').wrap_with_abbreviation)
      end,
    },
  },
  -- automatically check for plugin updates
  checker = { enabled = true, notify = false },
})
