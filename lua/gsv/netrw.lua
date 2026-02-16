vim.api.nvim_create_autocmd("FileType", {
  pattern = "netrw",
  callback = function()
    local function get_netrw_path()
        return vim.api.nvim_call_function('netrw#Call', {'NetrwFile', vim.fn['netrw#Call']('NetrwGetWord')})
    end

    -- vim.fn['netrw#Call']('Hide')
    vim.keymap.set('n', 'yp', function() vim.fn.setreg('+', get_netrw_path()) end, {buffer = true})
  end,
})

vim.keymap.set('n', '<leader>b.', '<Cmd>Lexplore<CR>', { desc = 'Toggle netrw on the left' })

vim.g.netrw_banner = 0
-- set this to 0 if you want `:e .` to use the buffer dir
vim.g.netrw_keepdir = 1
vim.g.netrw_liststyle = 3
vim.g.netrw_browse_split = 2
vim.g.netrw_altv = 0 -- left splitting
vim.g.netrw_winsize = 25

