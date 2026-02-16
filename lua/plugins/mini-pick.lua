return {
  {
    'nvim-mini/mini.pick',
    dependencies = { { "nvim-mini/mini.icons", opts = {} } },
    version = '*',
    config = function()
      local pick = require('mini.pick')

      pick.setup({
        options = {
          content_from_bottom = true,
          use_cache = true,
        },
      })

      vim.keymap.set('n', 'fp', function() pick.builtin.files({ tool = 'rg' }) end)
      vim.keymap.set('n', 'fg', function() pick.builtin.grep_live({ tool = 'rg'}) end)
    end,
  },
}
