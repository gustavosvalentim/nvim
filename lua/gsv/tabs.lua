vim.keymap.set("n", "<leader>tn", "<cmd>tabnew<cr>", { desc = "Create new tab" })
vim.keymap.set("n", "<leader>tc", "<cmd>tabclose<cr>", { desc = "Close current tab" })

for i = 1, 9, 1 do
  vim.keymap.set("n", "<leader>" .. i, i .. "gt", { desc = "Go to tab " .. i })
end
