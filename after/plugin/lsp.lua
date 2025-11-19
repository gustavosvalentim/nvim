-- Set completeopt to have a better completion experience
-- :help completeopt
-- menuone: popup even when there's only one match
-- noinsert: Do not insert text until a selection is made
-- noselect: Do not auto-select, nvim-cmp plugin will handle this for us.
vim.o.completeopt = "menuone,noinsert,noselect"

-- Avoid showing extra messages when using completion
vim.opt.shortmess = vim.opt.shortmess + "c"

-- Display inline diagnostics
vim.diagnostic.config({ virtual_text = true })

-- local cmp_capabilities = require("cmp_nvim_lsp").default_capabilities()
local cmp_capabilities = {}
local capabilities = vim.lsp.protocol.make_client_capabilities()

for k, v in ipairs(cmp_capabilities) do
  capabilities[k] = v
end

-- Lua
vim.lsp.config['lua_ls'] = {
  on_init = function(client)
    if client.workspace_folders then
      local path = client.workspace_folders[1].name
      if vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc') then
        return
      end
    end

    local client_config = {
      runtime = {
        -- Tell the language server which version of Lua you're using
        -- (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT'
      },
      -- Make the server aware of Neovim runtime files
      workspace = {
        checkThirdParty = false,
        library = {
          vim.env.VIMRUNTIME,
          -- Depending on the usage, you might want to add additional paths here.
          "${3rd}/luv/library",
          -- "${3rd}/busted/library",
        }
        -- or pull in all of 'runtimepath'. NOTE: this is a lot slower and will cause issues when working on your own configuration (see https://github.com/neovim/nvim-lspconfig/issues/3189)
        -- library = vim.api.nvim_get_runtime_file("", true)
      }
    }

    if type(client.config.settings.Lua) == "table" then
      client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, client_config)
    else
      client.config.settings.Lua = client_config
    end
  end,
  settings = {
    Lua = {}
  }
}

-- Go
vim.lsp.config['gopls'] = {
  settings = {
    gopls = {
      analyses = {
        unusedparams = true,
        ST1000 = false,
      },
      staticcheck = true,
    },
  },
}

-- Rust
vim.lsp.config['rust_analyzer'] = {
  on_attach = function(_, bufnr)
    vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
  end,
  cmd = { "rust-analyzer" },
  -- all the opts to send to nvim-lspconfig
  -- these override the defaults set by rust-tools.nvim
  -- see https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md#rust_analyzer
  settings = {
    -- to enable rust-analyzer settings visit:
    -- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
    ["rust-analyzer"] = {
      -- enable clippy on save
      checkOnSave = true,
      check = {
        command = "clippy",
        features = "all",
      },
      diagnostics = {
        enable = true,
        enableExperimental = true,
      },
      cargo = {
        loadOutDirsFromCheck = true,
        features = "all",
      },
      procMacro = {
        enable = true,
      },
      inlayHints = {
        chainingHints = true,
        parameterHints = false,
        typeHints = true,
      },
    },
  },
}

vim.lsp.config['basedpyright'] = {
  settings = {
    basedpyright = {
      analysis = {
        typeCheckingMode = "basic",
        deprecateTypingAliases = true,
        diagnosticSeverityOverrides = {
          reportDeprecated = "warning",
        },
        inlayHints = {
          variableTypes = true,
          functionReturnTypes = true,
          callArgumentNames = true,
          -- pytestParameters = true,
        },
      },
    },
  },
}

vim.lsp.config['ruff'] = {
  init_options = {
    settings = {
      lineLength = 100,
    },
  },
  on_attach = function(client, bufnr)
    client.server_capabilities.hoverProvider = false

    if client.supports_method("textDocument/formatting", bufnr) then
      vim.api.nvim_create_autocmd("BufWritePre", {
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format({ bufnr = bufnr, async = true })
        end,
      })
    end
  end
}

-- CMP
local servers = { 'lua_ls', 'gopls', 'rust_analyzer', 'ruff', 'basedpyright', 'ts_ls', 'emmet_language_server' }
for _, lsp in ipairs(servers) do
  vim.lsp.config[lsp]['capabilities'] = capabilities
  vim.lsp.enable(lsp)
end

-- Neovim LSP keymaps and config
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(args)
    -- keybinds/mappings/shortcuts
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local keymap_options = function(desc)
      return { buffer = args.buf, silent = true, desc = desc }
    end

    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, keymap_options('LSP: Goto Definition'))
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, keymap_options('LSP: Goto Implementation'))
    vim.keymap.set('n', 'gR', vim.lsp.buf.references, keymap_options('LSP: References'))
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, keymap_options('LSP: Hover'))
    vim.keymap.set('n', '.', vim.diagnostic.open_float, keymap_options('LSP: Diagnostic'))
    vim.keymap.set('n', '<leader>fmt', function() vim.lsp.buf.format { async = true } end, keymap_options('LSP: Format File'))
    vim.keymap.set('n', '<leader>rr', vim.lsp.buf.rename, keymap_options('LSP: Rename Symbol'))
  end
})

-- CMP (AutoComplete) config
-- local cmp = require 'cmp'
-- cmp.setup {
--   snippet = {
--     expand = function(args)
--       luasnip.lsp_expand(args.body)
--     end,
--   },
--   mapping = cmp.mapping.preset.insert({
--     ['<C-u>'] = cmp.mapping.scroll_docs(-4), -- Up
--     ['<C-d>'] = cmp.mapping.scroll_docs(4),  -- Down
--     -- C-b (back) C-f (forward) for snippet placeholder navigation.
--     ['<C-Space>'] = cmp.mapping.complete(),
--     ['<CR>'] = cmp.mapping.confirm {
--       behavior = cmp.ConfirmBehavior.Replace,
--       select = true,
--     },
--     ['<Tab>'] = cmp.mapping(function(fallback)
--       if cmp.visible() then
--         cmp.select_next_item()
--       else
--         fallback()
--       end
--     end, { 'i', 's' }),
--     ['<S-Tab>'] = cmp.mapping(function(fallback)
--       if cmp.visible() then
--         cmp.select_prev_item()
--       else
--         fallback()
--       end
--     end, { 'i', 's' }),
--   }),
--   sources = {
--     { name = 'nvim_lsp' },
--   },
-- }
