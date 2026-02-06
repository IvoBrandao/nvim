-- ═══════════════════════════════════════════════════════════════════════════
-- Telescope - Fuzzy Finder
-- Powerful fuzzy finder for files, text, LSP symbols, and more
-- ═══════════════════════════════════════════════════════════════════════════

return {
  {
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      {
        -- Native FZF sorter for better performance
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        cond = function()
          return vim.fn.executable('make') == 1
        end,
      },
      { 'nvim-telescope/telescope-ui-select.nvim' },
      { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
    },
    config = function()
      require('telescope').setup({
        defaults = {
          mappings = {
            i = {
              ['<C-u>'] = false,
              ['<C-d>'] = false,
              ['<C-k>'] = require('telescope.actions').move_selection_previous,
              ['<C-j>'] = require('telescope.actions').move_selection_next,
            },
          },
          -- Layout configuration
          layout_strategy = 'horizontal',
          layout_config = {
            horizontal = {
              preview_width = 0.55,
              results_width = 0.8,
            },
            width = 0.87,
            height = 0.80,
            preview_cutoff = 120,
          },
          -- File ignore patterns
          file_ignore_patterns = {
            'node_modules',
            '.git/',
            '.cache',
            '%.o',
            '%.a',
            '%.out',
            '%.class',
            '%.pdf',
            '%.mkv',
            '%.mp4',
            '%.zip',
          },
          -- Border style
          borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
          -- Color settings
          color_devicons = true,
          -- Use default prompt prefix
          prompt_prefix = '🔍 ',
          selection_caret = '  ',
          entry_prefix = '  ',
          -- Sorting strategy
          sorting_strategy = 'ascending',
          -- Selection strategy
          selection_strategy = 'reset',
          -- Path display
          path_display = { 'truncate' },
          -- Win blend (transparency)
          winblend = 0,
          -- Show hidden files
          hidden = true,
        },
        pickers = {
          -- Customize individual pickers
          find_files = {
            theme = 'dropdown',
            previewer = false,
            hidden = true,
          },
          buffers = {
            theme = 'dropdown',
            previewer = false,
            initial_mode = 'normal',
            mappings = {
              i = {
                ['<C-d>'] = require('telescope.actions').delete_buffer,
              },
              n = {
                ['dd'] = require('telescope.actions').delete_buffer,
              },
            },
          },
          git_files = {
            theme = 'dropdown',
            previewer = false,
          },
        },
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown(),
          },
        },
      })

      -- Enable extensions
      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'ui-select')

      -- Keybindings
      local builtin = require('telescope.builtin')

      -- File pickers
      vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = '[F]ind [F]iles' })
      vim.keymap.set('n', '<leader>fg', builtin.git_files, { desc = '[F]ind [G]it files' })
      vim.keymap.set('n', '<leader>fr', builtin.oldfiles, { desc = '[F]ind [R]ecent files' })
      vim.keymap.set('n', '<C-p>', builtin.find_files, { desc = 'Find files' })

      -- Search pickers
      vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
      vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
      vim.keymap.set('n', '<leader>/', function()
        builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown({
          winblend = 10,
          previewer = false,
        }))
      end, { desc = '[/] Fuzzily search in current buffer' })

      -- Vim pickers
      vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
      vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
      vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
      vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
      vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
      vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files' })
      vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find buffers' })

      -- LSP pickers (these are also defined in LSP config)
      vim.keymap.set('n', '<leader>fs', builtin.lsp_document_symbols, { desc = '[F]ind [S]ymbols' })
      vim.keymap.set('n', '<leader>fw', builtin.lsp_dynamic_workspace_symbols, { desc = '[F]ind [W]orkspace symbols' })

      -- Git pickers
      vim.keymap.set('n', '<leader>gc', builtin.git_commits, { desc = '[G]it [C]omm its' })
      vim.keymap.set('n', '<leader>gb', builtin.git_branches, { desc = '[G]it [B]ranches' })
      vim.keymap.set('n', '<leader>gs', builtin.git_status, { desc = '[G]it [S]tatus' })

      -- Search in open files
      vim.keymap.set('n', '<leader>s/', function()
        builtin.live_grep({
          grep_open_files = true,
          prompt_title = 'Live Grep in Open Files',
        })
      end, { desc = '[S]earch [/] in Open Files' })

      -- Search Neovim config files
      vim.keymap.set('n', '<leader>sn', function()
        builtin.find_files({ cwd = vim.fn.stdpath('config') })
      end, { desc = '[S]earch [N]eovim files' })
    end,
  },
}
