-- ═══════════════════════════════════════════════════════════════════════════
-- LSP Configuration
-- Language Server Protocol setup for multiple programming languages
-- ═══════════════════════════════════════════════════════════════════════════

return {
  -- Lua LSP helpers for Neovim development
  {
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        -- Load luvit types when using vim.uv
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
      },
    },
  },

  -- Main LSP Configuration
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Mason: LSP/DAP/Linter installer
      {
        'williamboman/mason.nvim',
        config = true,
      },
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',

      -- LSP status updates in bottom-right
      { 'j-hui/fidget.nvim', opts = {} },

      -- Additional completion capabilities from blink.cmp
      'saghen/blink.cmp',
    },
    config = function()
      -- ═══════════════════════════════════════════════════════════════════
      -- LSP Attach Configuration
      -- Executed when an LSP attaches to a buffer
      -- ═══════════════════════════════════════════════════════════════════
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
        callback = function(event)
          -- Helper function to set LSP keymaps
          local map = function(keys, func, desc, mode)
            mode = mode or 'n'
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          -- Jump to definition of symbol under cursor
          map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')

          -- Find all references to symbol under cursor
          map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')

          -- Jump to implementation (useful for interfaces)
          map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')

          -- Jump to type definition
          map('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')

          -- Fuzzy find symbols in current document
          map('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')

          -- Fuzzy find symbols in entire workspace
          map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

          -- Rename symbol under cursor
          map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')

          -- Execute code action (auto-fix, refactor, etc.)
          map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction', { 'n', 'x' })

          -- Jump to declaration (e.g., C header file)
          map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

          -- Show hover documentation
          map('K', vim.lsp.buf.hover, 'Hover Documentation')

          -- Show signature help (function parameters)
          map('<C-k>', vim.lsp.buf.signature_help, 'Signature Help')

          -- Document highlighting on cursor hold
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
            local highlight_augroup = vim.api.nvim_create_augroup('lsp-highlight', { clear = false })

            -- Highlight references when cursor is held
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })

            -- Clear highlights when cursor moves
            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })

            -- Clean up when LSP detaches
            vim.api.nvim_create_autocmd('LspDetach', {
              group = vim.api.nvim_create_augroup('lsp-detach', { clear = true }),
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds({ group = 'lsp-highlight', buffer = event2.buf })
              end,
            })
          end

          -- Inlay hints toggle (shows parameter names, types, etc.)
          if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
            map('<leader>th', function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
            end, '[T]oggle Inlay [H]ints')
          end
        end,
      })

      -- ═══════════════════════════════════════════════════════════════════
      -- LSP Capabilities
      -- Define what features this client supports
      -- ═══════════════════════════════════════════════════════════════════
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend('force', capabilities, require('blink.cmp').get_lsp_capabilities())

      -- ═══════════════════════════════════════════════════════════════════
      -- Language Servers Configuration
      -- Configure each language server with specific settings
      -- ═══════════════════════════════════════════════════════════════════
      local servers = {
        -- C/C++ Language Server
        clangd = {
          cmd = {
            'clangd',
            '--background-index',           -- Index project in background
            '--clang-tidy',                 -- Enable clang-tidy checks
            '--header-insertion=iwyu',      -- Insert headers with include-what-you-use
            '--completion-style=detailed',  -- Detailed completion items
            '--function-arg-placeholders',  -- Show function parameter placeholders
          },
          init_options = {
            clangdFileStatus = true,       -- Show file status in statusline
          },
        },

        -- Rust Language Server
        rust_analyzer = {
          settings = {
            ['rust-analyzer'] = {
              cargo = {
                allFeatures = true,        -- Enable all Cargo features
              },
              checkOnSave = {
                command = 'clippy',        -- Use clippy instead of check
              },
            },
          },
        },

        -- Python Language Server
        pyright = {
          settings = {
            python = {
              analysis = {
                autoSearchPaths = true,       -- Auto-detect Python paths
                useLibraryCodeForTypes = true, -- Infer types from library code
                diagnosticMode = 'workspace',  -- Analyze entire workspace
              },
            },
          },
        },

        -- TypeScript/JavaScript Language Server
        ts_ls = {
          settings = {
            typescript = {
              inlayHints = {
                includeInlayParameterNameHints = 'all',
                includeInlayFunctionParameterTypeHints = true,
                includeInlayVariableTypeHints = true,
              },
            },
            javascript = {
              inlayHints = {
                includeInlayParameterNameHints = 'all',
                includeInlayFunctionParameterTypeHints = true,
                includeInlayVariableTypeHints = true,
              },
            },
          },
        },

        --HTML Language Server
        html = {
          filetypes = { 'html', 'htmldjango' },
        },

        -- CSS Language Server
        cssls = {},

        -- Lua Language Server (optimized for Neovim config)
        lua_ls = {
          settings = {
            Lua = {
              completion = {
                callSnippet = 'Replace',  -- Replace function call with snippet
              },
              diagnostics = {
                globals = { 'vim' },      -- Recognize 'vim' as global
              },
              workspace = {
                checkThirdParty = false,  -- Don't prompt about third-party libs
              },
              telemetry = {
                enable = false,           -- Disable telemetry
              },
            },
          },
        },

        -- Markdown Language Server
        marksman = {},

        -- JSON Language Server
        jsonls = {},

        -- YAML Language Server
        yamlls = {},

        -- VHDL Language Server (rust_hdl from Mason)
        rust_hdl = {},

        -- Verilog/SystemVerilog Language Server
        -- Install verible separately for Verilog support
        verible = {},
      }

      -- ═══════════════════════════════════════════════════════════════════
      -- Tool Installation
      -- Ensure LSP servers, formatters, and linters are installed
      -- ═══════════════════════════════════════════════════════════════════
      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        -- Formatters
        'stylua',       -- Lua formatter
        'prettier',     -- Multi-language formatter (JS, TS, HTML, CSS, JSON, etc.)
        'black',        -- Python formatter
        'isort',        -- Python import sorter
        'clang-format', -- C/C++ formatter
        'rustfmt',      -- Rust formatter

        -- Linters
        'eslint_d',     -- JavaScript/TypeScript linter
        'pylint',       -- Python linter
        'markdownlint', -- Markdown linter
      })

      require('mason-tool-installer').setup({
        ensure_installed = ensure_installed,
        auto_update = false,
        run_on_start = true,
      })

      -- ═══════════════════════════════════════════════════════════════════
      -- LSP Server Setup
      -- Configure and start all language servers
      -- ═══════════════════════════════════════════════════════════════════
      require('mason-lspconfig').setup({
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            -- Merge capabilities with server-specific ones
            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
            require('lspconfig')[server_name].setup(server)
          end,
        },
      })

      -- ═══════════════════════════════════════════════════════════════════
      -- Diagnostic Configuration
      -- Configure how diagnostics (errors, warnings) are displayed
      -- ═══════════════════════════════════════════════════════════════════
      vim.diagnostic.config({
        virtual_text = {
          prefix = '●',      -- Prefix for virtual text
          source = 'if_many', -- Show source if multiple sources
        },
        signs = true,         -- Show signs in sign column
        underline = true,     -- Underline problematic code
        update_in_insert = false, -- Don't update diagnostics in insert mode
        severity_sort = true, -- Sort by severity
        float = {
          border = 'rounded',
          source = 'always', -- Always show diagnostic source
        },
      })

      -- Diagnostic signs in the gutter
      if vim.g.have_nerd_font then
        local signs = {
          ERROR = '',
          WARN = '',
          HINT = '',
          INFO = '',
        }
        for type, icon in pairs(signs) do
          local hl = 'DiagnosticSign' .. type
          vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
        end
      end
    end,
  },
}
