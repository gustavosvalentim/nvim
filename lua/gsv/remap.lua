vim.g.mapleader = " "

vim.keymap.set("n", "<leader>ex", vim.cmd.Ex, {})
vim.keymap.set("n", "<leader>bl", function() vim.cmd("buffers") end)
vim.keymap.set("n", "<leader>bf", function()
    local bufnr = vim.fn.input("Buffer: ")
    vim.cmd("buf "..bufnr)
end)

