vim.opt.guicursor = ""

vim.opt.nu = true
-- vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

-- 2-space indentation for web and config languages
vim.api.nvim_create_autocmd("FileType", {
  pattern = {
    "typescript",
    "typescriptreact",
    "javascript",
    "javascriptreact",
    "html",
    "htmldjango",
    "lua",
    "nix",
  },
  callback = function()
    vim.opt_local.tabstop = 2
    vim.opt_local.softtabstop = 2
    vim.opt_local.shiftwidth = 2
  end,
})

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.writebackup = false

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.updatetime = 50

vim.opt.signcolumn = "yes"

vim.opt.syntax = "enable"

-- set this to 0 if you want `:e .` to use the buffer dir
vim.g.netrw_keepdir = 1
vim.g.netrw_liststyle = 3
vim.g.netrw_altv = 1

vim.opt.foldmethod = "expr"
vim.opt.foldcolumn = "0"
vim.opt.foldtext = ""
vim.opt.foldlevel = 99
vim.opt.foldnestmax = 4

-- open settings
vim.keymap.set('n', '<C-,>', function() vim.cmd("e " .. vim.fn.stdpath("config")) end)

vim.opt.fileformat = "unix"
