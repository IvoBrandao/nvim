-- ═══════════════════════════════════════════════════════════════════════════
-- Debugging Configuration (DAP - Debug Adapter Protocol)
-- Full debugging support for multiple languages
-- ═══════════════════════════════════════════════════════════════════════════

return {
  'mfussenegger/nvim-dap',
  dependencies = {
    -- UI for debugger
    'rcarriga/nvim-dap-ui',

    -- Required dependency for dap-ui
    'nvim-neotest/nvim-nio',

    -- Automatically install debug adapters
    'williamboman/mason.nvim',
    'jay-babu/mason-nvim-dap.nvim',

    -- Language-specific debug adapters
    'leoluz/nvim-dap-go',        -- Go debugging
    'mfussenegger/nvim-dap-python', -- Python debugging
  },
  keys = {
    -- F5: Start/Continue debugging
    {
      '<F5>',
      function()
        require('dap').continue()
      end,
      desc = 'Debug: Start/Continue',
    },
    -- F10: Step over (execute current line, don't enter functions)
    {
      '<F10>',
      function()
        require('dap').step_over()
      end,
      desc = 'Debug: Step Over',
    },
    -- F11: Step into (enter function calls)
    {
      '<F11>',
      function()
        require('dap').step_into()
      end,
      desc = 'Debug: Step Into',
    },
    -- F12: Step out (exit current function)
    {
      '<F12>',
      function()
        require('dap').step_out()
      end,
      desc = 'Debug: Step Out',
    },
    -- Toggle breakpoint at current line
    {
      '<leader>db',
      function()
        require('dap').toggle_breakpoint()
      end,
      desc = '[D]ebug: Toggle [B]reakpoint',
    },
    -- Set conditional breakpoint
    {
      '<leader>dB',
      function()
        require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))
      end,
      desc = '[D]ebug: Set Conditional [B]reakpoint',
    },
    -- F7: Toggle debug UI
    {
      '<F7>',
      function()
        require('dapui').toggle()
      end,
      desc = 'Debug: Toggle UI',
    },
    -- Terminate debug session
    {
      '<leader>dt',
      function()
        require('dap').terminate()
      end,
      desc = '[D]ebug: [T]erminate',
    },
  },
  config = function()
    local dap = require('dap')
    local dapui = require('dapui')

    -- ═════════════════════════════════════════════════════════════════════
    -- Mason DAP Setup
    -- Automatically install and configure debug adapters
    -- ═════════════════════════════════════════════════════════════════════
    require('mason-nvim-dap').setup({
      automatic_installation = true,
      handlers = {},
      ensure_installed = {
        'codelldb',  -- C/C++/Rust debugger
        'python',    -- Python debugger
        'delve',     -- Go debugger
        'node2',     -- Node.js/JavaScript debugger
      },
    })

    -- ═════════════════════════════════════════════════════════════════════
    -- DAP UI Setup
    -- Configure the debugging user interface
    -- ═════════════════════════════════════════════════════════════════════
    dapui.setup({
      icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
      controls = {
        icons = {
          pause = '⏸',
          play = '▶',
          step_into = '⏎',
          step_over = '⏭',
          step_out = '⏮',
          step_back = '🔙',
          run_last = '▶▶',
          terminate = '⏹',
          disconnect = '⏏',
        },
      },
      layouts = {
        {
          -- Left sidebar: scopes, breakpoints, stacks, watches
          elements = {
            { id = 'scopes', size = 0.33 },
            { id = 'breakpoints', size = 0.17 },
            { id = 'stacks', size = 0.25 },
            { id = 'watches', size = 0.25 },
          },
          size = 40,
          position = 'left',
        },
        {
          -- Bottom panel: repl and console
          elements = {
            { id = 'repl', size = 0.5 },
            { id = 'console', size = 0.5 },
          },
          size = 10,
          position = 'bottom',
        },
      },
      floating = {
        max_height = 0.9,
        max_width = 0.5,
        border = 'rounded',
        mappings = {
          close = { 'q', '<Esc>' },
        },
      },
    })

    -- Change breakpoint icons
    vim.api.nvim_set_hl(0, 'DapBreak', { fg = '#e51400' })
    vim.api.nvim_set_hl(0, 'DapStop', { fg = '#ffcc00' })

    local breakpoint_icons = vim.g.have_nerd_font and {
      Breakpoint = '',
      BreakpointCondition = '',
      BreakpointRejected = '',
      LogPoint = '',
      Stopped = '',
    } or {
      Breakpoint = '●',
      BreakpointCondition = '⊜',
      BreakpointRejected = '⊘',
      LogPoint = '◆',
      Stopped = '⭔',
    }

    for type, icon in pairs(breakpoint_icons) do
      local tp = 'Dap' .. type
      local hl = (type == 'Stopped') and 'DapStop' or 'DapBreak'
      vim.fn.sign_define(tp, { text = icon, texthl = hl, numhl = hl })
    end

    -- ═════════════════════════════════════════════════════════════════════
    -- Auto-open/close UI
    -- Automatically show/hide debug UI when debugging starts/stops
    -- ═════════════════════════════════════════════════════════════════════
    dap.listeners.after.event_initialized['dapui_config'] = dapui.open
    dap.listeners.before.event_terminated['dapui_config'] = dapui.close
    dap.listeners.before.event_exited['dapui_config'] = dapui.close

    -- ═════════════════════════════════════════════════════════════════════
    -- Language-specific Configurations
    -- ═════════════════════════════════════════════════════════════════════

    -- Go debugging
    require('dap-go').setup({
      delve = {
        -- On Windows, delve must be run attached or it crashes
        detached = vim.fn.has('win32') == 0,
      },
    })

    -- Python debugging
    require('dap-python').setup('python')
  end,
}

