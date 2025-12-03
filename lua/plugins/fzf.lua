return {
  "ibhagwan/fzf-lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {
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
  },
  config = function()
    local fzf = require('fzf-lua')

    vim.keymap.set('n', 'fp', fzf.files)
    vim.keymap.set('n', 'fd', fzf.lgrep_curbuf)
    vim.keymap.set('n', 'fD', fzf.live_grep)
    vim.keymap.set('n', '<C-S-P>', fzf.commands)
  end
}
