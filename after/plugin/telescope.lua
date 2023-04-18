local telescope = require('telescope')
local builtin = require('telescope.builtin')

telescope.setup({
    defaults = {
        file_ignore_patterns = {
            "node_modules",
            "dist",
            ".git"
        },
    },
})

vim.keymap.set('n', '<leader>fp', builtin.find_files, { desc = 'find project files' })
vim.keymap.set('n', '<leader>fg', builtin.git_files, { desc = 'find git files' })
vim.keymap.set('n', '<leader>fk', builtin.keymaps, { desc = 'find keymaps' })
vim.keymap.set('n', '<leader>ff', builtin.current_buffer_fuzzy_find, { desc = 'fuzzy find current buffer' })
