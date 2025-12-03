local fzf = require('fzf-lua')

fzf.setup({
  commands = {
    actions = {
      ["default"] = function(selected)
        local cmd = selected[1]             -- e.g. "edit", "vsplit", etc.
        local ok, err = pcall(function() vim.cmd(cmd) end) -- execute immediately
        print("Command is ok: " .. tostring(ok))
        if not ok then
          vim.notify("Command failed: " .. err, vim.log.levels.ERROR)
        end
      end,
    },
  }
})

vim.keymap.set('n', '<leader>p', fzf.files)
vim.keymap.set('n', '<leader>f', fzf.lgrep_curbuf)
vim.keymap.set('n', '<leader>F', fzf.live_grep)
