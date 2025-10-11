require 'nvim-treesitter.configs'.setup {
  ensure_installed = { "c", "lua", "vim", "go", "rust", "python", "javascript", "typescript", "markdown", "markdown_inline", "html", "css", "scss" },
  sync_install = false,
  auto_install = true,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  }
}

vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
