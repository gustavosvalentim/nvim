-- Eviline config for lualine
-- Author: shadmansaleh
-- Credit: glepnir
local lualine = require('lualine')

-- Config
local config = {
  options = {
    -- Disable sections and component separators
    component_separators = '',
    section_separators = '',
    icons_enabled = true,
    theme = 'auto',
  },
  sections = {
    -- these are to remove the defaults
    lualine_a = {'mode'},
    lualine_b = {'branch'},
    lualine_c = {'diff', 'diagnostics', 'filename'},
    lualine_x = {'encoding', 'lsp_status'},
    lualine_y = {'filetype'},
    lualine_z = {'location'},
  },
  inactive_sections = {
    -- these are to remove the defaults
    lualine_a = {},
    lualine_b = {},
    lualine_y = {},
    lualine_z = {},
    lualine_c = {},
    lualine_x = {},
  },
}

-- Now don't forget to initialize lualine
lualine.setup(config)
