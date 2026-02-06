-- ═══════════════════════════════════════════════════════════════════════════
-- Neo-tree File Explorer
-- VSCode-like file explorer with git integration
-- ═══════════════════════════════════════════════════════════════════════════

return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons',
    'MunifTanjim/nui.nvim',
  },
  cmd = 'Neotree',
  keys = {
    { '<leader>e', ':Neotree toggle<CR>', desc = 'Toggle file [E]xplorer', silent = true },
    { '<leader>fe', ':Neotree focus<CR>', desc = '[F]ocus file [E]xplorer', silent = true },
    { '<leader>fg', ':Neotree float git_status<CR>', desc = '[F]loat [G]it status', silent = true },
  },
  opts = {
    -- Close neo-tree if it's the last window
    close_if_last_window = false,

    -- Pop up message when file is renamed or moved
    popup_border_style = 'rounded',

    -- Enable diagnostics in file explorer
    enable_diagnostics = true,

    -- Enable git status
    enable_git_status = true,

    -- Enable modified markers
    enable_modified_markers = true,

    -- Enable opened markers
    enable_refresh_on_write = true,

    -- Git status symbols
    git_status_async = true,

    -- Default component configs
    default_component_configs = {
      -- Indent guides
      indent = {
        indent_size = 2,
        padding = 1,
        with_markers = true,
        indent_marker = '│',
        last_indent_marker = '└',
        highlight = 'NeoTreeIndentMarker',
      },
      -- Icons
      icon = {
        folder_closed = '',
        folder_open = '',
        folder_empty = '',
        default = '',
      },
      -- Modified marker
      modified = {
        symbol = '[+]',
        highlight = 'NeoTreeModified',
      },
      -- Git status
      git_status = {
        symbols = {
          -- Change type
          added = '', -- or '✚'
          deleted = '', -- or '✖'
          modified = '', -- or ''
          renamed = '➜',
          -- Status type
          untracked = '',
          ignored = '',
          unstaged = '✗',
          staged = '✓',
          conflict = '',
        },
      },
    },

    -- Filesystem configuration
    filesystem = {
      -- Follow the currently focused file
      follow_current_file = {
        enabled = true,
        leave_dirs_open = false,
      },

      -- Use libuv file watcher for better performance
      use_libuv_file_watcher = true,

      -- Filtered items configuration
      filtered_items = {
        hide_dotfiles = false,
        hide_gitignored = false,
        hide_by_name = {
          '.git',
          'node_modules',
          '__pycache__',
          '.pytest_cache',
          '.mypy_cache',
          '.venv',
          'venv',
        },
        hide_by_pattern = {
          '*.pyc',
          '*.pyo',
        },
        always_show = {
          '.gitignored',
          '.env',
        },
        never_show = {
          '.DS_Store',
          'thumbs.db',
        },
      },

      -- Window configuration
      window = {
        mappings = {
          ['<leader>e'] = 'close_window',
          ['<space>'] = 'none',
          -- File operations
          ['a'] = {
            'add',
            config = {
              show_path = 'relative',
            },
          },
          ['A'] = 'add_directory',
          ['d'] = 'delete',
          ['r'] = 'rename',
          ['y'] = 'copy_to_clipboard',
          ['x'] = 'cut_to_clipboard',
          ['p'] = 'paste_from_clipboard',
          ['c'] = 'copy', -- Copy path
          ['m'] = 'move', -- Move/rename
          -- Navigation
          ['<bs>'] = 'navigate_up',
          ['.'] = 'set_root',
          ['H'] = 'toggle_hidden',
          ['g?'] = 'show_help',
          -- Opening files
          ['<cr>'] = 'open',
          ['<esc>'] = 'revert_preview',
          ['P'] = { 'toggle_preview', config = { use_float = true } },
          ['l'] = 'open',
          ['s'] = 'open_split',
          ['v'] = 'open_vsplit',
          ['t'] = 'open_tabnew',
          ['w'] = 'open_with_window_picker',
          -- Git
          ['gu'] = 'git_unstage_file',
          ['ga'] = 'git_add_file',
          ['gr'] = 'git_revert_file',
          ['gc'] = 'git_commit',
          ['gp'] = 'git_push',
          ['gg'] = 'git_commit_and_push',
          -- Refresh
          ['R'] = 'refresh',
        },
      },
    },

    -- Window configuration
    window = {
      position = 'left',
      width = 30,
      mapping_options = {
        noremap = true,
        nowait = true,
      },
      mappings = {
        ['<space>'] = 'none',
      },
    },

    -- Buffers configuration
    buffers = {
      follow_current_file = {
        enabled = true,
      },
      group_empty_dirs = true,
      show_unloaded = true,
    },

    -- Event handlers
    event_handlers = {
      {
        event = 'file_opened',
        handler = function()
          -- Auto-close neo-tree when file is opened
          require('neo-tree.command').execute({ action = 'close' })
        end,
      },
    },
  },
}
