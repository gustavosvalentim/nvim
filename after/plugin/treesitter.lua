require'nvim-treesitter.configs'.setup {
    ensure_installed = {"c", "lua", "vim", "go", "python", "javascript", "typescript", "help", "markdown", "markdown_inline"},
    sync_install = false,
    auto_install = true,
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    }
}
