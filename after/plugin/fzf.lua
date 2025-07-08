fzf = require('fzf-lua')

fzf.setup({ 'fzf-native' })

vim.keymap.set('n', '<C-p>', fzf.files)
vim.keymap.set('n', '<C-f>', fzf.lgrep_curbuf)
vim.keymap.set('n', '<C-S-f>', fzf.live_grep)
