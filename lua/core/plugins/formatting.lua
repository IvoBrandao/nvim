-- ═══════════════════════════════════════════════════════════════════════════
-- Code Formatting Configuration
-- Automatic code formatting for various languages
-- ═══════════════════════════════════════════════════════════════════════════

return {
  {
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    keys = {
      {
        '<leader>cf',
        function()
          require('conform').format({ async = true, lsp_fallback = true })
        end,
        mode = '',
        desc = '[C]ode [F]ormat',
      },
      {
        '<M-S-f>',
        function()
          require('conform').format({ async = true, lsp_fallback = true })
        end,
        mode = 'n',
        desc = 'Format document (Alt+Shift+F)',
      },
    },
    opts = {
      -- Show notification on formatting error
      notify_on_error = true,

      -- Format on save configuration
      format_on_save = function(bufnr)
        -- Disable format on save for certain filetypes
        local disable_filetypes = { markdown = true }
        if disable_filetypes[vim.bo[bufnr].filetype] then
          return
        end
        return {
          timeout_ms = 500,
          lsp_fallback = true, -- Use LSP formatting if no formatter available
        }
      end,

      -- Formatters by filetype
      formatters_by_ft = {
        -- Lua
        lua = { 'stylua' },

        -- Python
        python = { 'isort', 'black' }, -- Run isort first, then black

        -- JavaScript/TypeScript
        javascript = { 'prettier' },
        typescript = { 'prettier' },
        javascriptreact = { 'prettier' },
        typescriptreact = { 'prettier' },

        -- Web languages
        html = { 'prettier' },
        css = { 'prettier' },
        scss = { 'prettier' },

        -- Config formats
        json = { 'prettier' },
        jsonc = { 'prettier' },
        yaml = { 'prettier' },

        -- Markdown
        markdown = { 'prettier' },

        -- C/C++
        c = { 'clang_format' },
        cpp = { 'clang_format' },

        -- Rust (usually formatted via rust-analyzer)
        rust = { 'rustfmt' },

        -- Shell
        sh = { 'shfmt' },
        bash = { 'shfmt' },
      },

      -- Formatter-specific configuration
      formatters = {
        -- Example: customize clang-format style
        clang_format = {
          prepend_args = { '--style', 'Microsoft' }, -- Use Microsoft style
        },
        -- Example: customize prettier
        prettier = {
          prepend_args = { '--prose-wrap', 'always' },
        },
      },
    },
  },
}
