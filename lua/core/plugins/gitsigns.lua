-- ═══════════════════════════════════════════════════════════════════════════
-- Git Integration
-- Git signs in gutter and git hunk operations
-- ═══════════════════════════════════════════════════════════════════════════

return {
  -- Git signs in the gutter (added/modified/deleted lines)
  {
    'lewis6991/gitsigns.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    opts = {
      -- Visual indicators for git changes in the gutter
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
        untracked = { text = '┆' },
      },

      -- Sign column highlighting
      signcolumn = true,

      -- Number column highlighting
      numhl = false,

      -- Line highlighting
      linehl = false,

      -- Word diff highlighting
      word_diff = false,

      -- Watch gitdir for changes
      watch_gitdir = {
        interval = 1000,
        follow_files = true,
      },

      -- Attach to untracked files
      attach_to_untracked = true,

      -- Current line blame (shows git blame inline)
      current_line_blame = false,
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = 'eol',
        delay = 1000,
        ignore_whitespace = false,
      },
      current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',

      -- Sign priority
      sign_priority = 6,

      -- Update debounce
      update_debounce = 100,

      -- Status formatter
      status_formatter = nil,

      -- Max file length for enabling gitsigns
      max_file_length = 40000,

      -- Preview config
      preview_config = {
        border = 'rounded',
        style = 'minimal',
        relative = 'cursor',
        row = 0,
        col = 1,
      },

      -- Keymaps
      on_attach = function(bufnr)
        local gitsigns = require('gitsigns')

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation between hunks (changes)
        map('n', ']c', function()
          if vim.wo.diff then
            vim.cmd.normal({ ']c', bang = true })
          else
            gitsigns.nav_hunk('next')
          end
        end, { desc = 'Next git [c]hange' })

        map('n', '[c', function()
          if vim.wo.diff then
            vim.cmd.normal({ '[c', bang = true })
          else
            gitsigns.nav_hunk('prev')
          end
        end, { desc = 'Previous git [c]hange' })

        -- Actions
        map('n', '<leader>hs', gitsigns.stage_hunk, { desc = 'Git [h]unk [s]tage' })
        map('n', '<leader>hr', gitsigns.reset_hunk, { desc = 'Git [h]unk [r]eset' })
        map('v', '<leader>hs', function()
          gitsigns.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') })
        end, { desc = 'Git [h]unk [s]tage' })
        map('v', '<leader>hr', function()
          gitsigns.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') })
        end, { desc = 'Git [h]unk [r]eset' })
        map('n', '<leader>hS', gitsigns.stage_buffer, { desc = 'Git [h]unk [S]tage buffer' })
        map('n', '<leader>hu', gitsigns.undo_stage_hunk, { desc = 'Git [h]unk [u]ndo stage' })
        map('n', '<leader>hR', gitsigns.reset_buffer, { desc = 'Git [h]unk [R]eset buffer' })
        map('n', '<leader>hp', gitsigns.preview_hunk, { desc = 'Git [h]unk [p]review' })
        map('n', '<leader>hb', function()
          gitsigns.blame_line({ full = true })
        end, { desc = 'Git [h]unk [b]lame line' })
        map('n', '<leader>tb', gitsigns.toggle_current_line_blame, { desc = '[T]oggle git [b]lame line' })
        map('n', '<leader>hd', gitsigns.diffthis, { desc = 'Git [h]unk [d]iff against index' })
        map('n', '<leader>hD', function()
          gitsigns.diffthis('~')
        end, { desc = 'Git [h]unk [D]iff against last commit'})
        map('n', '<leader>td', gitsigns.toggle_deleted, { desc = '[T]oggle git show [d]eleted' })

        -- Text object for git hunks
        map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>', { desc = 'Select git hunk' })
      end,
    },
  },

  -- Lazygit integration - Full git UI in a floating terminal
  {
    'kdheepak/lazygit.nvim',
    cmd = {
      'LazyGit',
      'LazyGitConfig',
      'LazyGitCurrentFile',
      'LazyGitFilter',
      'LazyGitFilterCurrentFile',
    },
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    keys = {
      { '<leader>gg', '<cmd>LazyGit<cr>', desc = 'Open Lazy[G]it' },
      { '<leader>gf', '<cmd>LazyGitCurrentFile<cr>', desc = 'Lazy[G]it current [F]ile' },
    },
  },

  -- Diffview - Advanced diff and merge tool
  {
    'sindrets/diffview.nvim',
    cmd = { 'DiffviewOpen', 'DiffviewFileHistory' },
    keys = {
      { '<leader>gd', '<cmd>DiffviewOpen<cr>', desc = '[G]it [D]iff view' },
      { '<leader>gh', '<cmd>DiffviewFileHistory<cr>', desc = '[G]it [H]istory' },
      { '<leader>gH', '<cmd>DiffviewFileHistory %<cr>', desc = '[G]it [H]istory current file' },
    },
    opts = {},
  },
}
