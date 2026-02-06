-- ═══════════════════════════════════════════════════════════════════════════
-- Color Scheme Configuration
-- Theme configuration for Neovim
-- CURRENT THEME: OneDark Pro
-- ═══════════════════════════════════════════════════════════════════════════

return {
  -- OneDark Pro Theme (Active)
  {
    'olimorris/onedarkpro.nvim',
    priority = 1000,
    config = function()
      require('onedarkpro').setup({
        colors = {}, -- Override default colors
        highlights = {}, -- Override default highlight groups
        styles = {
          types = 'NONE',
          methods = 'NONE',
          numbers = 'NONE',
          strings = 'NONE',
          comments = 'italic',
          keywords = 'bold,italic',
          constants = 'NONE',
          functions = 'italic',
          operators = 'NONE',
          variables = 'NONE',
          parameters = 'NONE',
          conditionals = 'italic',
          virtual_text = 'NONE',
        },
        plugins = {
          barbar = false,
          copilot = false,
          dashboard = true,
          gitsigns = true,
          hop = false,
          indentline = true,
          leap = false,
          lsp_saga = false,
          lsp_semantic_tokens = true,
          marks = false,
          mason = true,
          neotest = false,
          neo_tree = true,
          nvim_cmp = true,
          nvim_bqf = false,
          nvim_dap = true,
          nvim_dap_ui = true,
          nvim_hlslens = false,
          nvim_lsp = true,
          nvim_navic = false,
          nvim_notify = true,
          nvim_tree = false,
          nvim_ts_rainbow = false,
          op_nvim = false,
          packer = false,
          polygot = false,
          startify = false,
          telescope = true,
          toggleterm = true,
          treesitter = true,
          trouble = false,
          vim_ultest = false,
          which_key = true,
        },
        options = {
          cursorline = true,
          transparency = false,
          terminal_colors = true,
          lualine_transparency = false,
          highlight_inactive_windows = false,
        },
      })
      vim.cmd.colorscheme('onedark')
    end,
  },

  -- Kanagawa (Alternative - Disabled)
  {
    'rebelot/kanagawa.nvim',
    enabled = false,
    priority = 1000, -- Load before other plugins
    config = function()
      require('kanagawa').setup({
        compile = false,              -- Don't compile theme for faster startup
        undercurl = true,              -- Enable undercurls for diagnostics
        commentStyle = { italic = true },
        functionStyle = {},
        keywordStyle = { italic = true },
        statementStyle = { bold = true },
        typeStyle = {},
        transparent = false,           -- Set to true for transparent background
        dimInactive = false,           -- Dim inactive windows
        terminalColors = true,         -- Define terminal colors

        -- Color overrides
        colors = {
          palette = {},
          theme = {
            wave = {},
            lotus = {},
            dragon = {},
            all = {
              ui = {
                bg_gutter = 'none', -- Remove gutter background
              },
            },
          },
        },

        -- Custom highlights
        overrides = function(colors)
          local theme = colors.theme
          return {
            -- Transparent floating windows
            NormalFloat = { bg = 'none' },
            FloatBorder = { bg = 'none' },
            FloatTitle = { bg = 'none' },

            -- Darker completion menu
            Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 },
            PmenuSel = { fg = 'NONE', bg = theme.ui.bg_p2 },
            PmenuSbar = { bg = theme.ui.bg_m1 },
            PmenuThumb = { bg = theme.ui.bg_p2 },

            -- Telescope borderless
            TelescopeTitle = { fg = theme.ui.special, bold = true },
            TelescopePromptNormal = { bg = theme.ui.bg_p1 },
            TelescopePromptBorder = { fg = theme.ui.bg_p1, bg = theme.ui.bg_p1 },
            TelescopeResultsNormal = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m1 },
            TelescopeResultsBorder = { fg = theme.ui.bg_m1, bg = theme.ui.bg_m1 },
            TelescopePreviewNormal = { bg = theme.ui.bg_dim },
            TelescopePreviewBorder = { bg = theme.ui.bg_dim, fg = theme.ui.bg_dim },
          }
        end,

        -- Theme variant: 'wave', 'dragon', 'lotus'
        theme = 'dragon',

        -- Background setting
        background = {
          dark = 'dragon',
          light = 'lotus',
        },
      })

      -- Load the colorscheme
      vim.cmd.colorscheme('kanagawa')
    end,
  },

  -- Alternative colorschemes (commented out)
  -- Uncomment to use a different theme

  --[[ TokyoNight
  {
    'folke/tokyonight.nvim',
    priority = 1000,
    config = function()
      require('tokyonight').setup({
        style = 'night', -- 'storm', 'moon', 'night', 'day'
        transparent = false,
        terminal_colors = true,
        styles = {
          comments = { italic = true },
          keywords = { italic = true },
          functions = {},
          variables = {},
        },
      })
      vim.cmd.colorscheme('tokyonight')
    end,
  },
  ]]

  --[[ Catppuccin
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
    config = function()
      require('catppuccin').setup({
        flavour = 'mocha', -- 'latte', 'frappe', 'macchiato', 'mocha'
        transparent_background = false,
        term_colors = true,
        styles = {
          comments = { 'italic' },
          conditionals = { 'italic' },
        },
      })
      vim.cmd.colorscheme('catppuccin')
    end,
  },
  ]]

  --[[ Gruvbox
  {
    'ellisonleao/gruvbox.nvim',
    priority = 1000,
    config = function()
      require('gruvbox').setup({
        terminal_colors = true,
        undercurl = true,
        underline = true,
        bold = true,
        italic = {
          strings = false,
          emphasis = true,
          comments = true,
          operators = false,
          folds = true,
        },
        contrast = '', -- '', 'hard', or 'soft'
      })
      vim.cmd.colorscheme('gruvbox')
    end,
  },
  ]]
}
