local fz = {}

fz.files = function(command)
  return function()
    local pick = require('mini.pick')

    local show_with_icons = function(buf_id, items, query)
        return pick.default_show(buf_id, items, query, { show_icons = true })
    end

    local opts = {
      command = command
    }

    local pick_opts = {
      source = {
        name = 'Files (All)',
        show = show_with_icons
      }
    }

    pick.builtin.cli(opts, pick_opts)
  end
end

fz.grep_live = function(tool)
  return function()
    local pick = require('mini.pick')
    local opts = {
      tool = tool
    }

    pick.builtin.grep_live(opts)
  end
end

fz.grep_buf = function()
  return function()
    local pick = require('mini.pick')
    local rel_path = vim.fn.expand('%:.')

    if rel_path == '' then return end

    pick.builtin.grep_live({ globs = { rel_path } })
  end
end

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

      vim.keymap.set('n', 'fp', fz.files({ 'rg', '--files', '--hidden', '--glob', '!.git' }))
      vim.keymap.set('n', 'fg', fz.grep_live('rg'))
      vim.keymap.set('n', 'fl', fz.grep_buf())
    end,
  },
}

