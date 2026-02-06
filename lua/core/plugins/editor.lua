-- ═══════════════════════════════════════════════════════════════════════════
-- Editor Enhancements
-- Additional tools to improve the editing experience
-- ═══════════════════════════════════════════════════════════════════════════

return {
  -- Auto-pairs for brackets, quotes, etc.
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    config = function()
      require('nvim-autopairs').setup({
        check_ts = true,  -- Use treesitter to check for pairs
        ts_config = {
          lua = { 'string', 'source' },
          javascript = { 'string', 'template_string' },
        },
        disable_filetype = { 'TelescopePrompt' },
        fast_wrap = {
          map = '<M-e>',  -- Alt+e to fast wrap
          chars = { '{', '[', '(', '"', "'" },
          pattern = [=[[%'%"%)%>%]%)%}%,]]=],
          end_key = '$',
          keys = 'qwertyuiopzxcvbnmasdfghjkl',
          check_comma = true,
          highlight = 'Search',
          highlight_grey = 'Comment',
        },
      })
    end,
  },

  -- Comment plugin with treesitter support
  {
    'numToStr/Comment.nvim',
    event = { 'BufReadPost', 'BufNewFile' },
    dependencies = {
      'JoosepAlviste/nvim-ts-context-commentstring',
    },
    config = function()
      require('Comment').setup({
        -- Use treesitter to determine comment string
        pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
        -- Line-comment keymap
        toggler = {
          line = 'gcc',  -- Toggle comment on current line
          block = 'gbc', -- Toggle block comment
        },
        -- Operator-pending keymap
        opleader = {
          line = 'gc',   -- Comment motion
          block = 'gb',  -- Block comment motion
        },
        -- Extra keymaps
        extra = {
          above = 'gcO', -- Comment line above
          below = 'gco', -- Comment line below
          eol = 'gcA',   -- Comment at end of line
        },
      })
    end,
  },

  -- Multiple cursors (VSCode-like multi-cursor editing)
  {
    'mg979/vim-visual-multi',
    event = { 'BufReadPost', 'BufNewFile' },
    init = function()
      -- Set VM (Visual Multi) leader to avoid conflicts
      vim.g.VM_leader = '\\\\'
      -- Default mappings
      vim.g.VM_maps = {
        ['Find Under'] = '<C-d>',           -- Start multi-cursor with Ctrl+d
        ['Find Subword Under'] = '<C-d>',   -- Same for subwords
      }
      -- Theme
      vim.g.VM_theme = 'iceblue'
    end,
  },

  -- Surround text objects (change/add/delete surrounding chars)
  {
    'kylechui/nvim-surround',
    version = '*',
    event = { 'BufReadPost', 'BufNewFile' },
    config = function()
      require('nvim-surround').setup({
        -- Configuration here, or leave empty for defaults
        keymaps = {
          insert = '<C-g>s',          -- Insert mode surround
          insert_line = '<C-g>S',     -- Insert mode line surround
          normal = 'ys',              -- Normal mode add surround
          normal_cur = 'yss',         -- Add surround to current line
          normal_line = 'yS',         -- Add surround on new lines
          normal_cur_line = 'ySS',    -- Add surround to current line on new lines
          visual = 'S',               -- Visual mode surround
          visual_line = 'gS',         -- Visual line mode surround
          delete = 'ds',              -- Delete surround
          change = 'cs',              -- Change surround
          change_line = 'cS',         -- Change surround with new lines
        },
      })
    end,
  },

  -- Better increment/decrement for numbers, dates, etc.
  {
    'monaqa/dial.nvim',
    keys = {
      {
        '<C-a>',
        function()
          return require('dial.map').inc_normal()
        end,
        expr = true,
        desc = 'Increment',
      },
      {
        '<C-x>',
        function()
          return require('dial.map').dec_normal()
        end,
        expr = true,
        desc = 'Decrement',
      },
      {
        'g<C-a>',
        function()
          return require('dial.map').inc_gvisual()
        end,
        expr = true,
        desc = 'Increment (visual)',
        mode = 'v',
      },
      {
        'g<C-x>',
        function()
          return require('dial.map').dec_gvisual()
        end,
        expr = true,
        desc = 'Decrement (visual)',
        mode = 'v',
      },
    },
    config = function()
      local augend = require('dial.augend')
      require('dial.config').augends:register_group({
        default = {
          augend.integer.alias.decimal,   -- Decimal numbers
          augend.integer.alias.hex,       -- Hex numbers
          augend.date.alias['%Y/%m/%d'],  -- Dates
          augend.constant.alias.bool,     -- true/false
          augend.semver.alias.semver,     -- Semantic versions
        },
      })
    end,
  },

  -- Highlight matching word under cursor
  {
    'RRethy/vim-illuminate',
    event = { 'BufReadPost', 'BufNewFile' },
    config = function()
      require('illuminate').configure({
        -- Providers: LSP, Treesitter, Regex
        providers = {
          'lsp',
          'treesitter',
          'regex',
        },
        -- Delay in milliseconds
        delay = 200,
        -- Filetypes to exclude
        filetypes_denylist = {
          'dirbuf',
          'dirvish',
          'fugitive',
          'neo-tree',
        },
        -- Don't highlight under cursor
        under_cursor = true,
        -- Minimum number of matches to highlight
        min_count_to_highlight = 1,
      })
    end,
  },

  -- Better quickfix window
  {
    'kevinhwang91/nvim-bqf',
    ft = 'qf',
    opts = {},
  },

  -- Show current code context (function/class name) at top
  {
    'nvim-treesitter/nvim-treesitter-context',
    event = { 'BufReadPost', 'BufNewFile' },
    opts = {
      enable = true,
      max_lines = 3,           -- How many lines to show
      min_window_height = 20,  -- Minimum editor height to show context
      line_numbers = true,
      multiline_threshold = 1,
      trim_scope = 'outer',
      mode = 'cursor',
      separator = nil,
    },
    keys = {
      {
        '<leader>tc',
        function()
          require('treesitter-context').toggle()
        end,
        desc = '[T]oggle [C]ontext',
      },
    },
  },
}
