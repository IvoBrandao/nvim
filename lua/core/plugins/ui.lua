-- ═══════════════════════════════════════════════════════════════════════════
-- UI Enhancements
-- VSCode-like UI features including bufferline, statusline, and notifications
-- ═══════════════════════════════════════════════════════════════════════════

return {
  -- BufferLine - VSCode-like tabs for buffers
  {
    'akinsho/bufferline.nvim',
    version = '*',
    dependencies = 'nvim-tree/nvim-web-devicons',
    event = 'VeryLazy',
    opts = {
      options = {
        -- Display mode: 'buffers' shows all buffers, 'tabs' shows vim tabs
        mode = 'buffers',
        numbers = 'none',
        -- Commands for closing/selecting buffers
        close_command = 'bdelete! %d',
        right_mouse_command = 'bdelete! %d',
        left_mouse_command = 'buffer %d',
        middle_mouse_command = nil,
        -- Visual indicators
        indicator = {
          icon = '▎',
          style = 'icon',
        },
        buffer_close_icon = '󰅖',
        modified_icon = '●',
        close_icon = '',
        left_trunc_marker = '',
        right_trunc_marker = '',
        -- Buffer name settings
        max_name_length = 18,
        max_prefix_length = 15,
        truncate_names = true,
        tab_size = 18,
        -- LSP diagnostics in bufferline
        diagnostics = 'nvim_lsp',
        diagnostics_update_in_insert = false,
        diagnostics_indicator = function(count, level)
          local icon = level:match('error') and ' ' or ' '
          return ' ' .. icon .. count
        end,
        -- Offset for file explorer
        offsets = {
          {
            filetype = 'neo-tree',
            text = 'File Explorer',
            text_align = 'center',
            separator = true,
          },
        },
        -- Display options
        color_icons = true,
        show_buffer_icons = true,
        show_buffer_close_icons = true,
        show_close_icon = true,
        show_tab_indicators = true,
        show_duplicate_prefix = true,
        persist_buffer_sort = true,
        separator_style = 'thin',
        enforce_regular_tabs = false,
        always_show_bufferline = true,
        -- Hover functionality
        hover = {
          enabled = true,
          delay = 200,
          reveal = { 'close' },
        },
        sort_by = 'insert_after_current',
      },
    },
  },

  -- Lualine - Statusline with VSCode-like appearance
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {
      options = {
        theme = 'auto',
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
        globalstatus = true, -- Single statusline for all windows
      },
      sections = {
        -- Left sections
        lualine_a = { 'mode' },
        lualine_b = { 'branch', 'diff', 'diagnostics' },
        lualine_c = { { 'filename', path = 1 } }, -- path=1 shows relative path
        -- Right sections
        lualine_x = { 'encoding', 'fileformat', 'filetype' },
        lualine_y = { 'progress' },
        lualine_z = { 'location' },
      },
    },
  },

  -- Noice - Better UI for messages, cmdline, and popups
  -- Note: Disabled by default as it can cause command line visibility issues
  -- To enable: remove 'enabled = false,' line below
  {
    'folke/noice.nvim',
    enabled = false,  -- DISABLED to fix command visibility issues
    event = 'VeryLazy',
    dependencies = {
      'MunifTanjim/nui.nvim',
      'rcarriga/nvim-notify',
    },
    opts = {
      cmdline = {
        enabled = true,
        view = 'cmdline',  -- Use classic cmdline view (not cmdline_popup)
      },
      messages = {
        enabled = true,
        view = 'notify',
        view_error = 'notify',
        view_warn = 'notify',
        view_history = 'messages',
        view_search = 'virtualtext',
      },
      lsp = {
        -- Override markdown rendering to use Noice
        override = {
          ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
          ['vim.lsp.util.stylize_markdown'] = true,
          ['cmp.entry.get_documentation'] = true,
        },
      },
      presets = {
        bottom_search = true,         -- Use classic bottom cmdline for search
        command_palette = false,       -- DISABLED: was causing command visibility issues
        long_message_to_split = true,  -- Long messages sent to split
        inc_rename = false,            -- Use input dialog for inc-rename.nvim
        lsp_doc_border = false,        -- Add border to hover docs and signature help
      },
    },
  },

  -- Improve default vim.ui interfaces (select, input)
  {
    'stevearc/dressing.nvim',
    event = 'VeryLazy',
    opts = {
      input = {
        -- Set to false to disable the vim.ui.input implementation
        enabled = true,
        -- Default prompt string
        default_prompt = 'Input:',
        -- Can be 'left', 'right', or 'center'
        prompt_align = 'left',
        -- When true, <Esc> will close the modal
        insert_only = true,
        -- When true, input will start in insert mode
        start_in_insert = true,
        -- These are passed to nvim_open_win
        border = 'rounded',
        -- 'editor' and 'win' will default to being centered
        relative = 'cursor',
      },
      select = {
        -- Set to false to disable the vim.ui.select implementation
        enabled = true,
        -- Priority list of preferred vim.select implementations
        backend = { 'telescope', 'fzf_lua', 'fzf', 'builtin', 'nui' },
        -- Options for telescope selector
        telescope = require('telescope.themes').get_dropdown(),
      },
    },
  },
}
