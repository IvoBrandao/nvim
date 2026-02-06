-- ═══════════════════════════════════════════════════════════════════════════
-- Modern Neovim Configuration
-- A comprehensive development environment with VSCode-like features
-- ═══════════════════════════════════════════════════════════════════════════

-- ═══════════════════════════════════════════════════════════════════════════
-- Leader Key Configuration
-- ═══════════════════════════════════════════════════════════════════════════
-- Set <space> as the leader key for custom mappings
-- Must be set before plugins are loaded to ensure correct key bindings
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- ═══════════════════════════════════════════════════════════════════════════
-- Font Configuration
-- ═══════════════════════════════════════════════════════════════════════════
-- Enable if you have a Nerd Font installed for better icons and symbols
vim.g.have_nerd_font = true

-- GUI Font Settings (for Neovide, nvim-qt, etc.)
if vim.g.neovide then
  vim.o.guifont = 'JetBrainsMono Nerd Font:h10' -- Font size 10
  vim.g.neovide_scale_factor = 0.6 -- Zoom level (0.6 = 60  %)
elseif vim.fn.exists('g:GuiLoaded') == 1 then
  vim.cmd('GuiFont! JetBrainsMono Nerd Font:h10')
end

-- Zoom in/out keybindings (works in GUI Neovim)
vim.keymap.set('n', '<C-=>', function()
  if vim.g.neovide then
    vim.g.neovide_scale_factor = vim.g.neovide_scale_factor + 0.1
  end
end, { desc = 'Zoom in' })

vim.keymap.set('n', '<C-->', function()
  if vim.g.neovide then
    vim.g.neovide_scale_factor = vim.g.neovide_scale_factor - 0.1
  end
end, { desc = 'Zoom out' })

vim.keymap.set('n', '<C-0>', function()
  if vim.g.neovide then
    vim.g.neovide_scale_factor = 0.8
  end
end, { desc = 'Reset zoom' })

-- ═══════════════════════════════════════════════════════════════════════════
-- Provider Configuration
-- ═══════════════════════════════════════════════════════════════════════════
-- Disable unused providers to suppress health check warnings
vim.g.loaded_perl_provider = 0  -- Disable Perl provider (not commonly used)

-- ═══════════════════════════════════════════════════════════════════════════
-- Editor Options
-- ═══════════════════════════════════════════════════════════════════════════

-- Line Numbers
vim.opt.number = true         -- Show absolute line numbers
vim.opt.relativenumber = true -- Show relative line numbers for easier navigation

-- Mouse Support
vim.opt.mouse = 'a'           -- Enable mouse support in all modes

-- Mode Display
vim.opt.showmode = false      -- Don't show mode (status line shows it)

-- Clipboard Integration
-- Sync clipboard between OS and Neovim for seamless copy/paste
vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)

-- Indentation
vim.opt.breakindent = true    -- Enable break indent for wrapped lines
vim.opt.smartindent = true    -- Smart autoindenting on new lines
vim.opt.expandtab = true      -- Convert tabs to spaces
vim.opt.tabstop = 2           -- Number of spaces a tab counts for
vim.opt.shiftwidth = 2        -- Number of spaces for auto-indent
vim.opt.softtabstop = 2       -- Number of spaces for <Tab> in insert mode

-- Undo History
vim.opt.undofile = true       -- Save undo history to file
vim.opt.undolevels = 10000    -- Maximum number of undo levels

-- Search Settings
vim.opt.ignorecase = true     -- Case-insensitive search
vim.opt.smartcase = true      -- Case-sensitive if capital letters present
vim.opt.hlsearch = true       -- Highlight search results
vim.opt.incsearch = true      -- Incremental search

-- UI Elements
vim.opt.signcolumn = 'yes'    -- Always show sign column (for git, diagnostics)
vim.opt.cursorline = true     -- Highlight current line
vim.opt.scrolloff = 10        -- Minimum lines to keep above/below cursor
vim.opt.sidescrolloff = 8     -- Minimum columns to keep left/right of cursor
vim.opt.colorcolumn = '80'    -- Show column border at 80 characters

-- Update Times
vim.opt.updatetime = 250      -- Faster completion and swap file writing
vim.opt.timeoutlen = 300      -- Time to wait for mapped sequence

-- Split Behavior
vim.opt.splitright = true     -- Vertical splits open to the right
vim.opt.splitbelow = true     -- Horizontal splits open below

-- Whitespace Characters
vim.opt.list = true           -- Show invisible characters
vim.opt.listchars = {
  tab = '» ',
  trail = '·',
  nbsp = '␣',
  extends = '›',
  precedes = '‹',
}

-- Command Line
vim.opt.inccommand = 'split'  -- Preview substitutions as you type

-- Completion Menu
vim.opt.pumheight = 10        -- Maximum height of popup menu
vim.opt.completeopt = 'menu,menuone,noselect'

-- Confirmation Dialogs
vim.opt.confirm = true        -- Ask to save instead of failing commands

-- Performance
vim.opt.lazyredraw = false    -- Don't redraw during macros (set to true if slow)

-- Wrapped Lines
vim.opt.wrap = false          -- Don't wrap long lines
vim.opt.linebreak = true      -- Break lines at word boundaries if wrap enabled

-- Folding (using treesitter)
vim.opt.foldmethod = 'expr'   -- Use expression for folding
vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
vim.opt.foldenable = false    -- Don't fold by default
vim.opt.foldlevel = 99        -- High fold level to keep folds open

-- ═══════════════════════════════════════════════════════════════════════════
-- Key Mappings
-- ═══════════════════════════════════════════════════════════════════════════

-- Clear search highlighting with <Esc>
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>', { desc = 'Clear search highlight' })

-- Diagnostic Navigation
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Better Window Navigation
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move to left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move to right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move to lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move to upper window' })

-- Window Management
vim.keymap.set('n', '<C-S-h>', '<C-w>H', { desc = 'Move window to left' })
vim.keymap.set('n', '<C-S-l>', '<C-w>L', { desc = 'Move window to right' })
vim.keymap.set('n', '<C-S-j>', '<C-w>J', { desc = 'Move window down' })
vim.keymap.set('n', '<C-S-k>', '<C-w>K', { desc = 'Move window up' })

-- Resize Windows
vim.keymap.set('n', '<C-Up>', ':resize +2<CR>', { desc = 'Increase window height', silent = true })
vim.keymap.set('n', '<C-Down>', ':resize -2<CR>', { desc = 'Decrease window height', silent = true })
vim.keymap.set('n', '<C-Left>', ':vertical resize -2<CR>', { desc = 'Decrease window width', silent = true })
vim.keymap.set('n', '<C-Right>', ':vertical resize +2<CR>', { desc = 'Increase window width', silent = true })

-- Better Indenting
vim.keymap.set('v', '<', '<gv', { desc = 'Indent left and reselect' })
vim.keymap.set('v', '>', '>gv', { desc = 'Indent right and reselect' })

-- Move Lines
vim.keymap.set('n', '<A-j>', ':m .+1<CR>==', { desc = 'Move line down', silent = true })
vim.keymap.set('n', '<A-k>', ':m .-2<CR>==', { desc = 'Move line up', silent = true })
vim.keymap.set('v', '<A-j>', ":m '>+1<CR>gv=gv", { desc = 'Move selection down', silent = true })
vim.keymap.set('v', '<A-k>', ":m '<-2<CR>gv=gv", { desc = 'Move selection up', silent = true })

-- Terminal Mode Keybindings
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
vim.keymap.set('t', '<C-h>', '<C-\\><C-n><C-w>h', { desc = 'Terminal: move to left window' })
vim.keymap.set('t', '<C-j>', '<C-\\><C-n><C-w>j', { desc = 'Terminal: move to lower window' })
vim.keymap.set('t', '<C-k>', '<C-\\><C-n><C-w>k', { desc = 'Terminal: move to upper window' })
vim.keymap.set('t', '<C-l>', '<C-\\><C-n><C-w>l', { desc = 'Terminal: move to right window' })

-- Buffer Navigation
vim.keymap.set('n', '<S-h>', ':bprevious<CR>', { desc = 'Previous buffer', silent = true })
vim.keymap.set('n', '<S-l>', ':bnext<CR>', { desc = 'Next buffer', silent = true })
vim.keymap.set('n', '<leader>bd', ':bdelete<CR>', { desc = '[B]uffer [D]elete', silent = true })

-- Quick Save
vim.keymap.set('n', '<C-s>', ':w<CR>', { desc = 'Save file', silent = true })
vim.keymap.set('i', '<C-s>', '<Esc>:w<CR>a', { desc = 'Save file', silent = true })

-- ═══════════════════════════════════════════════════════════════════════════
-- Autocommands
-- ═══════════════════════════════════════════════════════════════════════════

-- Highlight on yank (copy)
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking text',
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Auto-resize splits when window is resized
vim.api.nvim_create_autocmd('VimResized', {
  desc = 'Resize splits when window is resized',
  group = vim.api.nvim_create_augroup('resize-splits', { clear = true }),
  callback = function()
    vim.cmd('tabdo wincmd =')
  end,
})

-- Close certain filetypes with 'q'
vim.api.nvim_create_autocmd('FileType', {
  desc = 'Close certain filetypes with q',
  group = vim.api.nvim_create_augroup('close-with-q', { clear = true }),
  pattern = { 'help', 'lspinfo', 'man', 'qf', 'checkhealth' },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set('n', 'q', '<cmd>close<cr>', { buffer = event.buf, silent = true })
  end,
})

-- Check if file changed outside of vim
vim.api.nvim_create_autocmd({ 'FocusGained', 'TermClose', 'TermLeave' }, {
  desc = 'Check if file changed outside of vim',
  group = vim.api.nvim_create_augroup('checktime', { clear = true }),
  callback = function()
    if vim.o.buftype ~= 'nofile' then
      vim.cmd('checktime')
    end
  end,
})

-- ═══════════════════════════════════════════════════════════════════════════
-- Bootstrap lazy.nvim Plugin Manager
-- ═══════════════════════════════════════════════════════════════════════════

local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system({ 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end
vim.opt.rtp:prepend(lazypath)

-- ═══════════════════════════════════════════════════════════════════════════
-- Plugin Configuration
-- ═══════════════════════════════════════════════════════════════════════════
-- All plugin configurations are in:
--   - lua/core/plugins/*.lua  (core plugins)
--   - lua/custom/plugins/*.lua (user custom plugins)
--
-- To check plugin status:  :Lazy
-- To update plugins:  :Lazy update
-- To sync plugins:  :Lazy sync

require('lazy').setup({
  -- Automatically load all plugin configs from lua/core/plugins/
  { import = 'core.plugins' },

  -- Load custom user plugins from lua/custom/plugins/
  { import = 'custom.plugins' },
}, {
  -- ═════════════════════════════════════════════════════════════════════════
  -- Lazy.nvim Configuration
  -- ═════════════════════════════════════════════════════════════════════════

  -- Update checker: periodically checks for plugin updates
  checker = {
    enabled = true,  -- Automatically check for updates
    notify = true,   -- Notify when updates are found
    frequency = 3600, -- Check once per hour (in seconds)
  },

  -- UI configuration
  ui = {
    -- Use Nerd Font icons if available
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },

  -- Performance tuning
  performance = {
    cache = {
      enabled = true,
    },
    rtp = {
      -- Disable some default Vim plugins for faster startup
      disabled_plugins = {
        'gzip',
        'tarPlugin',
        'tohtml',
        'tutor',
        'zipPlugin',
      },
    },
  },
})

-- vim: ts=2 sts=2 sw=2 et
