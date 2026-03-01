-- ═══════════════════════════════════════════════════════════════════════════
-- Linting Configuration
-- Code linting for various languages
-- ═══════════════════════════════════════════════════════════════════════════

return {
  {
    'mfussenegger/nvim-lint',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      local lint = require('lint')

      -- Configure linters by filetype
      lint.linters_by_ft = {
        -- Python linting
        python = { 'pylint', 'mypy' },

        -- JavaScript/TypeScript linting
        javascript = { 'eslint_d' },
        typescript = { 'eslint_d' },
        javascriptreact = { 'eslint_d' },
        typescriptreact = { 'eslint_d' },

        -- Markdown linting
        markdown = { 'markdownlint' },

        -- Shell script linting
        sh = { 'shellcheck' },
        bash = { 'shellcheck' },

        -- YAML linting
        yaml = { 'yamllint' },

        -- JSON linting (removed - LSP provides validation)
        -- json = { 'jsonlint' },

        -- Dockerfile linting
        dockerfile = { 'hadolint' },
      }

      -- Create autocommand to run linters
      -- Runs on buffer enter, after write, and when leaving insert mode
      local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })
      vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
        group = lint_augroup,
        callback = function()
          -- Only run linter in modifiable buffers
          -- Avoids superfluous noise in LSP hover popups
          if vim.bo.modifiable then
            -- Use pcall to safely handle missing linters
            pcall(lint.try_lint)
          end
        end,
      })

      -- Manual lint trigger
      vim.keymap.set('n', '<leader>cl', function()
        -- Use pcall to safely handle missing linters
        pcall(lint.try_lint)
      end, { desc = '[C]ode [L]int' })
    end,
  },
}
