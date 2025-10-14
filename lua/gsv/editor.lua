vim.opt.guicursor = ""

vim.opt.nu = true
-- vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

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

vim.opt.foldmethod = "expr"
vim.opt.foldcolumn = "0"
vim.opt.foldtext = ""
vim.opt.foldlevel = 99
vim.opt.foldnestmax = 4

-- open settings
vim.keymap.set('n', '<C-,>', function() vim.cmd("e " .. vim.fn.stdpath("config")) end)

vim.opt.fileformat = "unix,dos"
