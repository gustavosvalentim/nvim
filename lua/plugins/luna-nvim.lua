return {
  "wtfox/luna.nvim",
  lazy = false,
  priority = 1000,
  opts = {
    transparent = false,
    accent = 1.0,
    plugins = {
      all = true,
      auto = true,
    }
  },
  config = function()
    vim.cmd.colorscheme('luna')
  end,
}
