-- ═══════════════════════════════════════════════════════════════════════════
-- Auto-pairs Configuration
-- Automatically close brackets, quotes, and other pairs
-- ═══════════════════════════════════════════════════════════════════════════

return {
  'windwp/nvim-autopairs',
  event = 'InsertEnter',
  config = function()
    require('nvim-autopairs').setup({
      -- Use treesitter to check for pairs
      check_ts = true,

      -- Treesitter configuration for specific filetypes
      ts_config = {
        lua = { 'string', 'source' },
        javascript = { 'string', 'template_string' },
        java = false, -- Don't check treesitter on java
      },

      -- Disable autopairs for specific filetypes
      disable_filetype = { 'TelescopePrompt', 'vim' },

      -- Disable when recording or executing a macro
      disable_in_macro = false,

      -- Disable when in visual mode
      disable_in_visualblock = false,

      -- Add spaces between parentheses
      -- Example: ( | ) instead of (|)
      disable_in_replace_mode = true,

      -- Ignored next characters regex
      ignored_next_char = [=[[%w%%%'%[%"%.%`%$]]=],

      -- Enable check bracket in same line
      enable_check_bracket_line = true,

      -- Don't add pairs if it already has a close pair in the same line
      enable_bracket_in_quote = true,

      -- Move right when repeated character
      enable_moveright = true,

      -- Check treesitter
      enable_afterquote = true,

      -- Map <CR> to insert mode
      map_cr = true,

      -- Map <BS> for delete pairs
      map_bs = true,

      -- Map <C-h> same as <BS>
      map_c_h = false,

      -- Map <C-w> to delete a pair if possible
      map_c_w = false,

      -- Fast wrap feature
      -- Press Alt+e to wrap word with pairs
      fast_wrap = {
        map = '<M-e>',
        chars = { '{', '[', '(', '"', "'" },
        pattern = [=[[%'%"%>%]%)%}%,]]=],
        end_key = '$',
        keys = 'qwertyuiopzxcvbnmasdfghjkl',
        check_comma = true,
        highlight = 'Search',
        highlight_grey = 'Comment',
      },
    })
  end,
}
