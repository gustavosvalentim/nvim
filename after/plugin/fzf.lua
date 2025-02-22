vim.keymap.set('n', '<C-p>', function() vim.cmd [[ :call fzf#vim#files('.') ]] end)
vim.keymap.set('n', '<C-f>', function() vim.cmd [[ :Rg ]] end)
