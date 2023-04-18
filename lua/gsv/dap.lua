-- nvim-dap-ui
require('dapui').setup()

vim.keymap.set('n', '<leader>dui', function() require('dapui').toggle() end)

-- go
require('dap-go').setup()

vim.keymap.set('n', '<leader>dt', function() require('dap-go').debug_test() end)

-- nvim-dap

vim.keymap.set('n', '<F5>', function() 
    require('dap').continue()
    require('dapui').open()
end)
vim.keymap.set('n', '<F10>', function() require('dap').step_over() end)
vim.keymap.set('n', '<F11>', function() require('dap').step_into() end)
vim.keymap.set('n', '<F12>', function() require('dap').step_out() end)
vim.keymap.set('n', '<Leader>b', function() require('dap').toggle_breakpoint() end)
