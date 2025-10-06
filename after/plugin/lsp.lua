-- Set completeopt to have a better completion experience
-- :help completeopt
-- menuone: popup even when there's only one match
-- noinsert: Do not insert text until a selection is made
-- noselect: Do not auto-select, nvim-cmp plugin will handle this for us.
vim.o.completeopt = "menuone,noinsert,noselect"

-- Avoid showing extra messages when using completion
vim.opt.shortmess = vim.opt.shortmess + "c"

local util = require('lspconfig/util')
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Lua
vim.lsp.config['lua_ls'] = {
  on_init = function(client)
    if client.workspace_folders then
      local path = client.workspace_folders[1].name
      if vim.loop.fs_stat(path..'/.luarc.json') or vim.loop.fs_stat(path..'/.luarc.jsonc') then
        return
      end
    end

    client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
      runtime = {
        -- Tell the language server which version of Lua you're using
        -- (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT'
      },
      -- Make the server aware of Neovim runtime files
      workspace = {
        checkThirdParty = false,
        library = {
          vim.env.VIMRUNTIME
          -- Depending on the usage, you might want to add additional paths here.
          -- "${3rd}/luv/library"
          -- "${3rd}/busted/library",
        }
        -- or pull in all of 'runtimepath'. NOTE: this is a lot slower and will cause issues when working on your own configuration (see https://github.com/neovim/nvim-lspconfig/issues/3189)
        -- library = vim.api.nvim_get_runtime_file("", true)
      }
    })
  end,
  settings = {
    Lua = {}
  }
}

-- Go
vim.lsp.config['gopls'] = {
    cmd = {'gopls', 'serve'},
    filetypes = {'go', 'gomod'},
    root_dir = util.root_pattern('go.work', 'go.mod', '.git'),
    settings = {
      gopls = {
        analyses = {
          unusedparams = true,
        },
        staticcheck = true,
      },
    },
}

-- Rust
vim.lsp.config['rust_analyzer'] = {
    on_attach = function(client, bufnr)
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
                typeCheckingMode = "standard",
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
    }
}

-- CMP
local servers = { 'lua_ls', 'gopls', 'rust_analyzer', 'basedpyright', 'ts_ls' }
for _, lsp in ipairs(servers) do
    vim.lsp.config[lsp]['capabilities'] = capabilities
    vim.lsp.enable(lsp)
end

-- Neovim LSP keymaps and config
vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(ev)
        -- vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

        -- mappings
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local opts = { buffer = ev.buf }
        -- vim.keymap.set('n', '<leader>gD', vim.lsp.buf.declaration, opts)
        vim.keymap.set('n', '<F12>', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', '<A-F12>', vim.lsp.buf.hover, opts)
        -- MacOS
        vim.keymap.set('n', '<F60>', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', '<C-F12>', vim.lsp.buf.implementation, opts)
        -- MacOS
        vim.keymap.set('n', '<F36>', vim.lsp.buf.implementation, opts)
        vim.keymap.set('n', '<S-F12>', vim.lsp.buf.references, opts)
        -- MacOS
        vim.keymap.set('n', '<F24>', vim.lsp.buf.references, opts)
        vim.keymap.set('n', '.', vim.diagnostic.open_float, opts)
        vim.keymap.set('n', '<leader>f', function()
            vim.lsp.buf.format { async = true }
        end, opts)
    end
})

-- CMP config
local cmp = require 'cmp'
cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-u>'] = cmp.mapping.scroll_docs(-4), -- Up
    ['<C-d>'] = cmp.mapping.scroll_docs(4), -- Down
    -- C-b (back) C-f (forward) for snippet placeholder navigation.
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end, { 'i', 's' }),
  }),
  sources = {
    { name = 'nvim_lsp' },
  },
}
