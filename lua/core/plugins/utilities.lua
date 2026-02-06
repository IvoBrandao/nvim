-- ═══════════════════════════════════════════════════════════════════════════
-- Utility Plugins
-- Small helper plugins that enhance the editing experience
-- ═══════════════════════════════════════════════════════════════════════════

return {
  -- ═══════════════════════════════════════════════════════════════════════════
  -- Which-Key: Show pending keybinds
  -- Displays a popup with possible keybindings when you start typing a sequence
  -- ═══════════════════════════════════════════════════════════════════════════
  {
    'folke/which-key.nvim',
    event = 'VimEnter',
    opts = {
      -- Delay between pressing a key and opening which-key (milliseconds)
      -- This setting is independent of vim.o.timeoutlen
      delay = 0,

      icons = {
        -- Set icon mappings to true if you have a Nerd Font
        mappings = vim.g.have_nerd_font,

        -- If you are using a Nerd Font: set icons.keys to an empty table which will use the
        -- default which-key.nvim defined Nerd Font icons, otherwise define a string table
        keys = vim.g.have_nerd_font and {} or {
          Up = '<Up> ',
          Down = '<Down> ',
          Left = '<Left> ',
          Right = '<Right> ',
          C = '<C-…> ',
          M = '<M-…> ',
          D = '<D-…> ',
          S = '<S-…> ',
          CR = '<CR> ',
          Esc = '<Esc> ',
          ScrollWheelDown = '<ScrollWheelDown> ',
          ScrollWheelUp = '<ScrollWheelUp> ',
          NL = '<NL> ',
          BS = '<BS> ',
          Space = '<Space> ',
          Tab = '<Tab> ',
          F1 = '<F1> ',
          F2 = '<F2> ',
          F3 = '<F3> ',
          F4 = '<F4> ',
          F5 = '<F5> ',
          F6 = '<F6> ',
          F7 = '<F7> ',
          F8 = '<F8> ',
          F9 = '<F9> ',
          F10 = '<F10> ',
          F11 = '<F11> ',
          F12 = '<F12> ',
        },
      },

      -- Document existing key chains
      spec = {
        { '<leader>c', group = '[C]ode', mode = { 'n', 'x' } },
        { '<leader>d', group = '[D]ocument' },
        { '<leader>r', group = '[R]ename' },
        { '<leader>s', group = '[S]earch' },
        { '<leader>w', group = '[W]orkspace' },
        { '<leader>t', group = '[T]oggle' },
        { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
        { '<leader>f', group = '[F]ind' },
        { '<leader>g', group = '[G]it' },
        { '<leader>b', group = '[B]uffer' },
      },
    },
  },

  -- ═══════════════════════════════════════════════════════════════════════════
  -- Guess Indent: Automatically detect indentation
  -- Detects and applies the indentation style of the file you open
  -- ═══════════════════════════════════════════════════════════════════════════
  {
    'NMAC427/guess-indent.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    opts = {
      -- Enable automatic detection
      auto_cmd = true,

      -- Override editorconfig if it exists
      override_editorconfig = false,

      -- Filetypes to exclude from detection
      filetype_exclude = {
        'help',
        'lazy',
        'mason',
        'neo-tree',
        'dashboard',
      },

      -- Buffer types to exclude from detection
      buftype_exclude = {
        'help',
        'nofile',
        'terminal',
        'prompt',
      },
    },
  },

  -- ═══════════════════════════════════════════════════════════════════════════
  -- Todo Comments: Highlight and search for todo comments
  -- Highlights TODO, HACK, WARNING, NOTE, etc. in your code
  -- ═══════════════════════════════════════════════════════════════════════════
  {
    'folke/todo-comments.nvim',
    event = 'VimEnter',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = {
      -- Don't show signs in the sign column
      signs = false,

      -- Sign priority
      sign_priority = 8,

      -- Keywords to highlight
      keywords = {
        FIX = {
          icon = ' ', -- icon used for the sign
          color = 'error', -- highlight group
          alt = { 'FIXME', 'BUG', 'FIXIT', 'ISSUE' }, -- alternative keywords
        },
        TODO = { icon = ' ', color = 'info' },
        HACK = { icon = ' ', color = 'warning' },
        WARN = { icon = ' ', color = 'warning', alt = { 'WARNING', 'XXX' } },
        PERF = { icon = ' ', color = 'default', alt = { 'OPTIM', 'PERFORMANCE', 'OPTIMIZE' } },
        NOTE = { icon = ' ', color = 'hint', alt = { 'INFO' } },
        TEST = { icon = '⏲ ', color = 'test', alt = { 'TESTING', 'PASSED', 'FAILED' } },
      },

      -- Highlighting style
      gui_style = {
        fg = 'NONE', -- foreground style
        bg = 'BOLD', -- background style
      },

      -- Merge keywords with default keywords
      merge_keywords = true,

      -- Enable highlighting for specific words with custom patterns
      highlight = {
        multiline = true, -- enable multiline todo comments
        multiline_pattern = '^.', -- lua pattern to match the next multiline from the start of the matched keyword
        multiline_context = 10, -- extra lines that will be re-evaluated when changing a line
        before = '', -- 'fg' or 'bg' or empty
        keyword = 'wide', -- 'fg', 'bg', 'wide', 'wide_bg', 'wide_fg' or empty
        after = 'fg', -- 'fg' or 'bg' or empty
        pattern = [[.*<(KEYWORDS)\s*:]], -- pattern or table of patterns, used for highlighting
        comments_only = true, -- uses treesitter to match keywords in comments only
        max_line_len = 400, -- ignore lines longer than this
        exclude = {}, -- list of file types to exclude highlighting
      },

      -- List of named colors where we try to extract the guifg from the
      -- list of highlight groups or use the hex color if hl not found as a fallback
      colors = {
        error = { 'DiagnosticError', 'ErrorMsg', '#DC2626' },
        warning = { 'DiagnosticWarn', 'WarningMsg', '#FBBF24' },
        info = { 'DiagnosticInfo', '#2563EB' },
        hint = { 'DiagnosticHint', '#10B981' },
        default = { 'Identifier', '#7C3AED' },
        test = { 'Identifier', '#FF00FF' },
      },

      -- Search configuration
      search = {
        command = 'rg',
        args = {
          '--color=never',
          '--no-heading',
          '--with-filename',
          '--line-number',
          '--column',
        },
        -- regex  that will be used to match keywords
        -- don't replace the (KEYWORDS) placeholder
        pattern = [[\b(KEYWORDS):]], -- ripgrep regex
      },
    },
    -- Keybindings
    keys = {
      {
        ']t',
        function()
          require('todo-comments').jump_next()
        end,
        desc = 'Next todo comment',
      },
      {
        '[t',
        function()
          require('todo-comments').jump_prev()
        end,
        desc = 'Previous todo comment',
      },
      { '<leader>st', '<cmd>TodoTelescope<cr>', desc = '[S]earch [T]odos' },
      { '<leader>sT', '<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>', desc = '[S]earch [T]odos/Fix/Fixme' },
    },
  },
}
