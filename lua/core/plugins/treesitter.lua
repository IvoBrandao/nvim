-- ═══════════════════════════════════════════════════════════════════════════
-- Treesitter Configuration
-- Syntax highlighting and code understanding via tree-sitter
-- ═══════════════════════════════════════════════════════════════════════════

return {
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    event = { 'BufReadPost', 'BufNewFile' },
    dependencies = {
      --Treesitter text objects for better code navigation
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    config = function()
      local ok, ts_configs = pcall(require, 'nvim-treesitter.configs')
      if not ok or not ts_configs then
        vim.notify('nvim-treesitter not installed; skipping treesitter setup', vim.log.levels.WARN)
        return
      end

      ts_configs.setup({
        -- Languages to automatically install
        ensure_installed = {
          'bash',
          'c',
          'cpp',
          'css',
          'diff',
          'html',
          'javascript',
          'json',
          'lua',
          'luadoc',
          'markdown',
          'markdown_inline',
          'python',
          'query',
          'rust',
          'typescript',
          'vim',
          'vimdoc',
          'yaml',
          'toml',
          'regex',
        },

        -- Automatically install missing parsers when entering buffer
        auto_install = true,

        -- Syntax highlighting
        highlight = {
          enable = true,
          -- Disable slow treesitter highlight for large files
          disable = function(lang, buf)
            local max_filesize = 100 * 1024 -- 100 KB
            local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
            if ok and stats and stats.size > max_filesize then
              return true
            end
          end,
          -- Use vim regex highlighting in addition to treesitter
          additional_vim_regex_highlighting = false,
        },

        -- Indentation based on treesitter
        indent = {
          enable = true,
          -- Disable for languages where it causes issues
          disable = { 'python' },
        },

        -- Incremental selection
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = '<C-space>',    -- Start selection
            node_incremental = '<C-space>',  -- Increment to next node
            scope_incremental = false,       -- Increment to scope (disabled)
            node_decremental = '<bs>',       -- Decrement to previous node
          },
        },

        -- Text objects for better code navigation
        textobjects = {
          select = {
            enable = true,
            lookahead = true, -- Automatically jump forward to textobj
            keymaps = {
              -- Functions
              ['af'] = '@function.outer',  -- Select around function
              ['if'] = '@function.inner',  -- Select inside function
              -- Classes
              ['ac'] = '@class.outer',     -- Select around class
              ['ic'] = '@class.inner',     -- Select inside class
              -- Parameters
              ['aa'] = '@parameter.outer', -- Select around parameter
              ['ia'] = '@parameter.inner', -- Select inside parameter
              -- Conditionals
              ['ai'] = '@conditional.outer',
              ['ii'] = '@conditional.inner',
              -- Loops
              ['al'] = '@loop.outer',
              ['il'] = '@loop.inner',
            },
          },
          move = {
            enable = true,
            set_jumps = true, -- Whether to set jumps in the jumplist
            goto_next_start = {
              [']m'] = '@function.outer',  -- Next function start
              [']]'] = '@class.outer',     -- Next class start
            },
            goto_next_end = {
              [']M'] = '@function.outer',  -- Next function end
              [']['] = '@class.outer',     -- Next class end
            },
            goto_previous_start = {
              ['[m'] = '@function.outer',  -- Previous function start
              ['[['] = '@class.outer',     -- Previous class start
            },
            goto_previous_end = {
              ['[M'] = '@function.outer',  -- Previous function end
              ['[]'] = '@class.outer',     -- Previous class end
            },
          },
          swap = {
            enable = true,
            swap_next = {
              ['<leader>a'] = '@parameter.inner', -- Swap parameter with next
            },
            swap_previous = {
              ['<leader>A'] = '@parameter.inner', -- Swap parameter with previous
            },
          },
        },
      })
    end,
  },
}
