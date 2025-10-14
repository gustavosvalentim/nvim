local fzf = require('fzf-lua')

fzf.setup({ 'fzf-native' })

vim.keymap.set('n', '<leader>p', fzf.files)
vim.keymap.set('n', '<leader>f', fzf.lgrep_curbuf)
vim.keymap.set('n', '<leader>F', fzf.live_grep)
