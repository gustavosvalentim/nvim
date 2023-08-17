function transparent_bg()
    vim.api.nvim_set_hl(0, 'Normal', { bg = 'none' })
    vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'none' })
end

function colorize(color)
    color = color or 'github_dark'
    vim.cmd.colorscheme(color)

    -- transparent_bg()
end

colorize('github_dark_high_contrast')
