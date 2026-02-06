-- ═══════════════════════════════════════════════════════════════════════════
-- Dashboard - OneDark Pro Theme
-- A clean, professional dashboard matching OneDark Pro colors
-- ═══════════════════════════════════════════════════════════════════════════

return {
  'nvimdev/dashboard-nvim',
  event = 'VimEnter',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    require('dashboard').setup({
      theme = 'doom',
      config = {
        header = {
          '',
          '',
          '',
          '    ⠀⠀⡖⠉⠉⢦⠀⠀⠀⠀⠀⠀⢀⣀⣀⣀⣀⡀⠀⠀⠀⠀⠀⠀⡰⠊⠉⢢⠀⠀',
          '    ⡔⠉⠁⠀⠀⢎⠀⠀⠀⣠⠖⠋⠀⠀⠀⠀⠀⠈⠙⠢⣄⠀⠀⠀⡱⠀⠀⠈⠙⢂',
          '    ⠣⣀⣀⢄⠀⠀⠑⢤⠞⢡⠎⡴⢠⠀⠀⠀⠀⠀⢆⠐⡌⠳⡤⠊⠀⠀⡠⣀⣀⠜',
          '    ⠀⠀⠀⠀⠑⢄⣀⣿⣿⡿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡄⡠⠊⠀⠀⠀⠀',
          '    ⠀⠀⢠⠤⠤⠤⠽⠿⠾⠿⠷⠿⠾⠷⠿⠾⠷⠿⠾⠷⠿⠾⠷⠯⠤⠤⠤⢄⠀⠀',
          '    ⠀⠀⠈⠉⠉⠉⠹⡉⠉⠉⣉⣭⣍⡉⠉⠉⠉⣩⣭⣉⠉⠉⠉⡏⠉⠉⠉⠁⠀⠀',
          '    ⠀⠀⠀⠀⠀⠀⠀⢳⠀⠰⣿⣿⣿⣷⠀⠀⣾⣿⣿⣿⡇⠀⡼⠀⠀⠀⠀⠀⠀⠀',
          '    ⠀⠀⠀⠀⠀⠀⠀⠀⠱⣄⠙⠿⠟⠋⢀⣀⠘⠛⠿⠛⣠⠞⠀⠀⠀⠀⠀⠀⠀⠀',
          '    ⠀⠀⠀⠀⠀⠀⠀⠀⠀⡨⡗⠢⢤⢀⣈⣉⡀⡤⠖⢾⢅⠀⠀⠀⠀⠀⠀⠀⠀⠀',
          '    ⠀⠀⠀⠀⠀⠀⠀⡠⠊⢰⠓⠢⡾⣀⣀⣇⣀⣧⠄⠺⡆⠑⢤⠀⠀⠀⠀⠀⠀⠀',
          '    ⠀⠀⢀⠊⠉⠑⠋⠀⢀⣸⠁⠲⠧⢀⣀⣇⣀⠸⠔⠊⣇⠀⠀⠑⠊⠉⠲⡀⠀⠀',
          '    ⠀⠀⠈⢤⣀⠀⠀⠰⡍⠈⢃⠀⠀⠀⠀⠀⠀⠀⠀⡸⠁⢱⠂⠀⠀⣀⡰⠁⠀⠀',
          '    ⠀⠀⠀⠀⠘⢄⣀⡠⠃⠀⠀⠑⠤⠄⠀⠀⠠⠤⠊⠀⠀⠘⢄⣀⡠⠃⠀⠀⠀⠀',
          '',
          '',
          '',
        },
        center = {
          {
            icon = '  ',
            icon_hl = 'DashboardIcon',
            desc = 'New File                ',
            desc_hl = 'DashboardDesc',
            key = 'n',
            key_hl = 'DashboardKey',
            action = 'enew',
          },
          {
            icon = '  ',
            icon_hl = 'DashboardIcon',
            desc = 'Find File               ',
            desc_hl = 'DashboardDesc',
            key = 'f',
            key_hl = 'DashboardKey',
            action = 'Telescope find_files',
          },
          {
            icon = '  ',
            icon_hl = 'DashboardIcon',
            desc = 'Recent Files            ',
            desc_hl = 'DashboardDesc',
            key = 'r',
            key_hl = 'DashboardKey',
            action = 'Telescope oldfiles',
          },
          {
            icon = '  ',
            icon_hl = 'DashboardIcon',
            desc = 'Find Text               ',
            desc_hl = 'DashboardDesc',
            key = 'g',
            key_hl = 'DashboardKey',
            action = 'Telescope live_grep',
          },
          {
            icon = '  ',
            icon_hl = 'DashboardIcon',
            desc = 'Find Buffers            ',
            desc_hl = 'DashboardDesc',
            key = 'b',
            key_hl = 'DashboardKey',
            action = 'Telescope buffers',
          },
          {
            icon = '  ',
            icon_hl = 'DashboardIcon',
            desc = 'Find Help               ',
            desc_hl = 'DashboardDesc',
            key = 'h',
            key_hl = 'DashboardKey',
            action = 'Telescope help_tags',
          },
          {
            icon = '  ',
            icon_hl = 'DashboardIcon',
            desc = 'Config                  ',
            desc_hl = 'DashboardDesc',
            key = 'c',
            key_hl = 'DashboardKey',
            action = 'edit ~/.config/nvim/init.lua',
          },
          {
            icon = '  ',
            icon_hl = 'DashboardIcon',
            desc = 'Plugins                 ',
            desc_hl = 'DashboardDesc',
            key = 'p',
            key_hl = 'DashboardKey',
            action = 'Lazy',
          },
          {
            icon = '  ',
            icon_hl = 'DashboardIcon',
            desc = 'Mason (LSP/Tools)       ',
            desc_hl = 'DashboardDesc',
            key = 'm',
            key_hl = 'DashboardKey',
            action = 'Mason',
          },
          {
            icon = '  ',
            icon_hl = 'DashboardIcon',
            desc = 'Quit                    ',
            desc_hl = 'DashboardDesc',
            key = 'q',
            key_hl = 'DashboardKey',
            action = 'qa',
          },
        },
        footer = function()
          local stats = require('lazy').stats()
          local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)

          return {
            '',
            '',
            string.format('⚡ Loaded %d plugins in %.2f ms', stats.loaded, ms),
            '',
          }
        end,
      },
      hide = {
        statusline = false,
        tabline = false,
        winbar = false,
      },
    })

    -- OneDark Pro color scheme for dashboard
    vim.api.nvim_create_autocmd('FileType', {
      pattern = 'dashboard',
      callback = function()
        -- OneDark Pro colors matching the theme
        vim.api.nvim_set_hl(0, 'DashboardHeader', { fg = '#61afef', bold = true })  -- Blue
        vim.api.nvim_set_hl(0, 'DashboardIcon', { fg = '#c678dd', bold = true })    -- Purple
        vim.api.nvim_set_hl(0, 'DashboardDesc', { fg = '#abb2bf' })                 -- Foreground
        vim.api.nvim_set_hl(0, 'DashboardKey', { fg = '#e5c07b', bold = true })     -- Yellow
        vim.api.nvim_set_hl(0, 'DashboardFooter', { fg = '#98c379', italic = true }) -- Green

        -- Disable some options for cleaner look
        vim.opt_local.number = false
        vim.opt_local.relativenumber = false
        vim.opt_local.cursorline = false
        vim.opt_local.colorcolumn = ''
      end,
    })

    -- Auto-open dashboard when starting Neovim without arguments
    if vim.fn.argc() == 0 then
      vim.api.nvim_create_autocmd('VimEnter', {
        callback = function()
          require('dashboard').instance:open()
        end,
      })
    end
  end,
}
