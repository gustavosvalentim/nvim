local fzf = require('fzf-lua')

fzf.setup({ 'fzf-native' })

vim.keymap.set('n', '<leader>p', fzf.files)
vim.keymap.set('n', '<leader>ff', fzf.lgrep_curbuf)
vim.keymap.set('n', '<leader>fp', fzf.live_grep)
