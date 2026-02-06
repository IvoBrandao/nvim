-- ═══════════════════════════════════════════════════════════════════════════
-- Terminal Integration
-- Integrated terminal with floating window support
-- ═══════════════════════════════════════════════════════════════════════════

return {
  {
    'akinsho/toggleterm.nvim',
    version = '*',
    keys = {
      { '<C-\\>', desc = 'Toggle terminal' },
    },
    opts = {
      -- Size of terminal window
      size = function(term)
        if term.direction == 'horizontal' then
          return 15
        elseif term.direction == 'vertical' then
          return vim.o.columns * 0.4
        end
      end,

      -- Key to toggle terminal
      open_mapping = [[<C-\>]],

      -- Hide line numbers in terminal
      hide_numbers = true,

      -- Shade the terminal slightly darker
      shade_terminals = true,
      shading_factor = 2,

      -- Start terminal in insert mode
      start_in_insert = true,
      insert_mappings = true,  -- Apply open_mapping in insert mode
      terminal_mappings = true, -- Apply open_mapping in terminal mode

      -- Persist terminal size
      persist_size = true,
      persist_mode = true,

      -- Terminal direction: 'vertical' | 'horizontal' | 'tab' | 'float'
      direction = 'float',

      -- Close terminal when process exits
      close_on_exit = true,

      -- Shell to use
      shell = vim.o.shell,

      -- Auto scroll to bottom when output appears
      auto_scroll = true,

      -- Float terminal configuration
      float_opts = {
        -- Border style: 'single' | 'double' | 'shadow' | 'curved' | 'none'
        border = 'curved',
        -- Transparency (0-100, 0 = opaque)
        winblend = 0,
        -- Highlight group for floating window
        highlights = {
          border = 'Normal',
          background = 'Normal',
        },
        -- Width and height as percentage of editor
        width = function()
          return math.floor(vim.o.columns * 0.9)
        end,
        height = function()
          return math.floor(vim.o.lines * 0.9)
        end,
      },

      -- Window options
      winbar = {
        enabled = false,
      },
    },
    config = function(_, opts)
      require('toggleterm').setup(opts)

      -- Custom terminal instances
      local Terminal = require('toggleterm.terminal').Terminal

      -- Lazygit terminal
      local lazygit = Terminal:new({
        cmd = 'lazygit',
        dir = 'git_dir',
        direction = 'float',
        float_opts = {
          border = 'double',
        },
        on_open = function(term)
          vim.cmd('startinsert!')
          vim.api.nvim_buf_set_keymap(term.bufnr, 'n', 'q', '<cmd>close<CR>', { noremap = true, silent = true })
        end,
      })

      function _lazygit_toggle()
        lazygit:toggle()
      end

      -- Python REPL terminal
      local python = Terminal:new({
        cmd = 'python3',
        direction = 'float',
        close_on_exit = false,
      })

      function _python_toggle()
        python:toggle()
      end

      -- Node REPL terminal
      local node = Terminal:new({
        cmd = 'node',
        direction = 'float',
        close_on_exit = false,
      })

      function _node_toggle()
        node:toggle()
      end

      -- htop system monitor
      local htop = Terminal:new({
        cmd = 'htop',
        direction = 'float',
      })

      function _htop_toggle()
        htop:toggle()
      end

      -- Keymaps for custom terminals
      vim.keymap.set('n', '<leader>gg', '<cmd>lua _lazygit_toggle()<CR>', { desc = 'Toggle Lazy[G]it', silent = true })
      vim.keymap.set('n', '<leader>tp', '<cmd>lua _python_toggle()<CR>', { desc = '[T]erminal [P]ython', silent = true })
      vim.keymap.set('n', '<leader>tn', '<cmd>lua _node_toggle()<CR>', { desc = '[T]erminal [N]ode', silent = true })
      vim.keymap.set('n', '<leader>tt', '<cmd>lua _htop_toggle()<CR>', { desc = '[T]erminal h[T]op', silent = true })

      -- Additional terminal keymaps
      vim.keymap.set('n', '<leader>th', '<cmd>ToggleTerm direction=horizontal<CR>', { desc = '[T]erminal [H]orizontal', silent = true })
      vim.keymap.set('n', '<leader>tv', '<cmd>ToggleTerm direction=vertical<CR>', { desc = '[T]erminal [V]ertical', silent = true })
      vim.keymap.set('n', '<leader>tf', '<cmd>ToggleTerm direction=float<CR>', { desc = '[T]erminal [F]loat', silent = true })
    end,
  },
}
