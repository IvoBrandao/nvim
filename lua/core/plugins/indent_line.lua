-- ═══════════════════════════════════════════════════════════════════════════
-- Indent Guides
-- Visual indent guides for better code readability
-- ═══════════════════════════════════════════════════════════════════════════

return {
  {
    'lukas-reineke/indent-blankline.nvim',
    event = { 'BufReadPost', 'BufNewFile' },
    main = 'ibl',
    opts = {
      -- Indentation character
      indent = {
        char = '▏',
        tab_char = '▏',
      },

      -- Scope configuration (current code block)
      scope = {
        enabled = true,
        show_start = true,     -- Show underline on first line
        show_end = false,      -- Don't show underline on last line
        show_exact_scope = false,
        injected_languages = true,
        highlight = { 'Function', 'Label' },
        priority = 500,
      },

      -- Exclude certain filetypes
      exclude = {
        filetypes = {
          'help',
          'alpha',
          'dashboard',
          'neo-tree',
          'Trouble',
          'trouble',
          'lazy',
          'mason',
          'notify',
          'toggleterm',
          'lazyg it',
        },
        buftypes = {
          'terminal',
          'nofile',
        },
      },
    },
  },
}
