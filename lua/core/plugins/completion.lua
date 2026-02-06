-- ═══════════════════════════════════════════════════════════════════════════
-- Auto-completion Configuration
-- Provides intelligent code completion with snippets
-- ═══════════════════════════════════════════════════════════════════════════

return {
  {
    'saghen/blink.cmp',
    version = '*',
    dependencies = {
      -- Snippet collection
      'rafamadriz/friendly-snippets',
      -- Snippet engine
      {
        'L3MON4D3/LuaSnip',
        version = 'v2.*',
        build = 'make install_jsregexp',
      },
    },
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      -- Key mappings for completion
      keymap = {
        preset = 'default',  -- Use default keybindings
        -- Tab for selection and snippet navigation
        ['<Tab>'] = { 'select_next', 'snippet_forward', 'fallback' },
        ['<S-Tab>'] = { 'select_prev', 'snippet_backward', 'fallback' },
        -- Ctrl-Space to trigger completion
        ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
        -- Enter to accept completion
        ['<CR>'] = { 'accept', 'fallback' },
        -- Ctrl-e to close completion menu
        ['<C-e>'] = { 'hide' },
        -- Navigate completion menu
        ['<C-n>'] = { 'select_next', 'fallback' },
        ['<C-p>'] = { 'select_prev', 'fallback' },
        -- Scroll docs
        ['<C-u>'] = { 'scroll_documentation_up', 'fallback' },
        ['<C-d>'] = { 'scroll_documentation_down', 'fallback' },
      },

      -- Appearance settings
      appearance = {
        -- Use 'mono' for Nerd Font Mono or 'normal' for regular Nerd Font
        nerd_font_variant = 'mono',
      },

      -- Completion menu configuration
      completion = {
        -- Documentation window settings
        documentation = {
          auto_show = true,           -- Automatically show documentation
          auto_show_delay_ms = 500,   -- Delay before showing docs
        },
        menu = {
          draw = {
            -- Column layout: label, kind icon, and kind text
            columns = { { 'label', 'label_description', gap = 1 }, { 'kind_icon', 'kind' } },
          },
        },
      },

      -- Completion sources configuration
      sources = {
        -- Default sources for completion
        default = { 'lsp', 'path', 'snippets', 'buffer', 'lazydev' },
        providers = {
          -- Lua development (Neovim API) completion
          lazydev = {
            name = 'LazyDev',
            module = 'lazydev.integrations.blink',
            score_offset = 100, -- Prioritize lazydev completions
          },
        },
      },

      -- Snippet configuration
      snippets = {
        -- Use LuaSnip as snippet engine
        expand = function(snippet)
          require('luasnip').lsp_expand(snippet)
        end,
        active = function(filter)
          if filter and filter.direction then
            return require('luasnip').jumpable(filter.direction)
          end
          return require('luasnip').in_snippet()
        end,
        jump = function(direction)
          require('luasnip').jump(direction)
        end,
      },
    },
  },
}
