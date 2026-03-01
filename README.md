# 🚀 Modern Neovim Configuration

A modular Neovim configuration designed for development with VSCode-like features and plugin ecosystem.

![Modern Neovim Screenshot](image.png)

## ✨ Overview

Neovim is configured as an IDE with code completion, debugging support, git integration, and user interface components. Plugins are configured and documented for performance and development workflow.

### 🎯 Key Features

- **🌍 Multi-Language Support**: IDE functionality for 12+ programming languages
- **🧠 Code Completion**: Context-aware autocompletion with snippets via blink.cmp
- **🐛 Debugging Support**: DAP integration for C/C++, Python, Go, Rust, and JavaScript
- **⚡ Performance**: Lazy loading and performance optimization
- **🎨 User Interface**: VSCode-like interface with bufferline, statusline, and dashboard
- **📁 File Management**: Fuzzy finding and tree explorer with git integration
- **🔧 Development Tools**: Formatting, linting, and code actions across languages

## 📦 Complete Plugin Inventory

### 🎛️ Core Infrastructure

| Plugin | Purpose | Configuration |
|--------|---------|---------------|
| [lazy.nvim](https://github.com/folke/lazy.nvim) | Plugin manager with lazy loading | [init.lua](init.lua#L235) |
| [mason.nvim](https://github.com/williamboman/mason.nvim) | LSP/DAP/Tool installer | [lsp.lua](lua/core/plugins/lsp.lua) |
| [plenary.nvim](https://github.com/nvim-lua/plenary.nvim) | Lua utility library | Dependency |

### 🧠 Language Server Protocol (LSP)

| Plugin | Purpose | Configuration |
|--------|---------|---------------|
| [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) | LSP client configurations | [lsp.lua](lua/core/plugins/lsp.lua) |
| [mason-lspconfig.nvim](https://github.com/williamboman/mason-lspconfig.nvim) | Mason-LSP bridge | [lsp.lua](lua/core/plugins/lsp.lua) |
| [mason-tool-installer.nvim](https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim) | Auto-install tools | [lsp.lua](lua/core/plugins/lsp.lua) |
| [fidget.nvim](https://github.com/j-hui/fidget.nvim) | LSP progress UI | [lsp.lua](lua/core/plugins/lsp.lua) |
| [lazydev.nvim](https://github.com/folke/lazydev.nvim) | Lua development for Neovim | [lsp.lua](lua/core/plugins/lsp.lua) |

**Supported Language Servers:**

- **C/C++**: clangd with clang-tidy integration
- **Rust**: rust-analyzer with clippy support
- **Python**: pyright with workspace analysis
- **TypeScript/JavaScript**: ts_ls with inlay hints
- **HTML/CSS**: html and cssls servers
- **Lua**: lua_ls optimized for Neovim
- **Markdown**: marksman server
- **JSON/YAML**: jsonls and yamlls
- **VHDL/Verilog**: rust_hdl and verible

### 🔤 Autocompletion System

| Plugin | Purpose | Configuration |
|--------|---------|---------------|
| [blink.cmp](https://github.com/saghen/blink.cmp) | Modern completion engine | [completion.lua](lua/core/plugins/completion.lua) |
| [friendly-snippets](https://github.com/rafamadriz/friendly-snippets) | Snippet collection | [completion.lua](lua/core/plugins/completion.lua) |
| [LuaSnip](https://github.com/L3MON4D3/LuaSnip) | Snippet engine | [completion.lua](lua/core/plugins/completion.lua) |

**Features**: Code completion with LSP integration, snippet expansion, documentation preview, and fuzzy matching.

### 🌳 Syntax & Code Understanding

| Plugin | Purpose | Configuration |
|--------|---------|---------------|
| [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) | Syntax highlighting & parsing | [treesitter.lua](lua/core/plugins/treesitter.lua) |
| [nvim-treesitter-textobjects](https://github.com/nvim-treesitter/nvim-treesitter-textobjects) | Smart text objects | [treesitter.lua](lua/core/plugins/treesitter.lua) |
| [nvim-treesitter-context](https://github.com/nvim-treesitter/nvim-treesitter-context) | Sticky function headers | [editor.lua](lua/core/plugins/editor.lua) |

**Features**: Syntax highlighting, code folding, text selection, and context awareness.

### 🔍 Fuzzy Finding & Navigation

| Plugin | Purpose | Configuration |
|--------|---------|---------------|
| [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) | Fuzzy finder framework | [telescope.lua](lua/core/plugins/telescope.lua) |
| [telescope-fzf-native.nvim](https://github.com/nvim-telescope/telescope-fzf-native.nvim) | Native FZF sorter | [telescope.lua](lua/core/plugins/telescope.lua) |
| [telescope-ui-select.nvim](https://github.com/nvim-telescope/telescope-ui-select.nvim) | UI selector replacement | [telescope.lua](lua/core/plugins/telescope.lua) |

**Pickers Available**:

- 📁 Files: `<leader>ff` (find files), `<C-p>` (quick search)
- 🔍 Text: `<leader>sg` (live grep), `<leader>sw` (word search)
- 📊 LSP: `<leader>fs` (symbols), `<leader>fw` (workspace symbols)
- 📚 Help: `<leader>sh` (help tags), `<leader>sk` (keymaps)

### 📁 File Management

| Plugin | Purpose | Configuration |
|--------|---------|---------------|
| [neo-tree.nvim](https://github.com/nvim-neo-tree/neo-tree.nvim) | File explorer with git integration | [neo-tree.lua](lua/core/plugins/neo-tree.lua) |
| [nvim-web-devicons](https://github.com/nvim-tree/nvim-web-devicons) | File type icons | Dependency |
| [nui.nvim](https://github.com/MunifTanjim/nui.nvim) | UI component library | Dependency |

**Features**: Git status integration, file operations, fuzzy search, and auto-close on file open.

### 🎨 User Interface

| Plugin | Purpose | Configuration |
|--------|---------|---------------|
| [bufferline.nvim](https://github.com/akinsho/bufferline.nvim) | VSCode-like buffer tabs | [ui.lua](lua/core/plugins/ui.lua) |
| [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim) | Statusline with git/LSP info | [ui.lua](lua/core/plugins/ui.lua) |
| [dashboard-nvim](https://github.com/nvimdev/dashboard-nvim) | Startup dashboard | [dashboard.lua](lua/core/plugins/dashboard.lua) |
| [dressing.nvim](https://github.com/stevearc/dressing.nvim) | Better vim.ui interfaces | [ui.lua](lua/core/plugins/ui.lua) |
| [indent-blankline.nvim](https://github.com/lukas-reineke/indent-blankline.nvim) | Indentation guides | [indent_line.lua](lua/core/plugins/indent_line.lua) |

### 🎨 Color Schemes

| Plugin | Purpose | Status | Configuration |
|--------|---------|--------|---------------|
| [onedarkpro.nvim](https://github.com/olimorris/onedarkpro.nvim) | OneDark Pro theme | **Active** | [colorscheme.lua](lua/core/plugins/colorscheme.lua) |
| [kanagawa.nvim](https://github.com/rebelot/kanagawa.nvim) | Alternative Japanese theme | Disabled | [colorscheme.lua](lua/core/plugins/colorscheme.lua) |

**Available Alternatives** (commented out): TokyoNight, Catppuccin, Gruvbox

### 🔗 Git Integration

| Plugin | Purpose | Configuration |
|--------|---------|---------------|
| [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) | Git change indicators | [gitsigns.lua](lua/core/plugins/gitsigns.lua) |
| [lazygit.nvim](https://github.com/kdheepak/lazygit.nvim) | Lazygit integration | [gitsigns.lua](lua/core/plugins/gitsigns.lua) |
| [diffview.nvim](https://github.com/sindrets/diffview.nvim) | Git diff viewer | [gitsigns.lua](lua/core/plugins/gitsigns.lua) |

**Git Features**:

- 📍 Gutter signs for added/modified/deleted lines
- 🚀 Full lazygit interface (`<leader>gg`)
- 👁️ Diff viewing and file history
- ⚡ Hunk navigation and staging (`]c`, `[c`)

### ✏️ Editor Enhancements

| Plugin | Purpose | Configuration |
|--------|---------|---------------|
| [nvim-autopairs](https://github.com/windwp/nvim-autopairs) | Auto-close brackets/quotes | [autopairs.lua](lua/core/plugins/autopairs.lua) |
| [Comment.nvim](https://github.com/numToStr/Comment.nvim) | Smart commenting | [editor.lua](lua/core/plugins/editor.lua) |
| [nvim-surround](https://github.com/kylechui/nvim-surround) | Surround text objects | [editor.lua](lua/core/plugins/editor.lua) |
| [vim-visual-multi](https://github.com/mg979/vim-visual-multi) | Multi-cursor editing | [editor.lua](lua/core/plugins/editor.lua) |
| [dial.nvim](https://github.com/monaqa/dial.nvim) | Enhanced increment/decrement | [editor.lua](lua/core/plugins/editor.lua) |
| [vim-illuminate](https://github.com/RRethy/vim-illuminate) | Highlight word under cursor | [editor.lua](lua/core/plugins/editor.lua) |

**Key Bindings**:

- `<C-d>`: Multi-cursor like VSCode
- `ys`: Add surround, `ds`: Delete surround, `cs`: Change surround
- `gcc`: Toggle line comment, `gc`: Comment motion

### 🔧 Code Formatting & Linting

| Plugin | Purpose | Configuration |
|--------|---------|---------------|
| [conform.nvim](https://github.com/stevearc/conform.nvim) | Code formatting | [formatting.lua](lua/core/plugins/formatting.lua) |
| [nvim-lint](https://github.com/mfussenegger/nvim-lint) | Code linting | [lint.lua](lua/core/plugins/lint.lua) |

**Supported Formatters**:

- **Lua**: stylua
- **Python**: black + isort
- **JavaScript/TypeScript**: prettier
- **C/C++**: clang-format
- **Web**: prettier (HTML, CSS, JSON, YAML, Markdown)

**Supported Linters**:

- **Python**: pylint, mypy
- **JavaScript/TypeScript**: eslint_d
- **Markdown**: markdownlint
- **Shell**: shellcheck
- **Docker**: hadolint

### 🐛 Debugging (DAP)

| Plugin | Purpose | Configuration |
|--------|---------|---------------|
| [nvim-dap](https://github.com/mfussenegger/nvim-dap) | Debug Adapter Protocol | [debug.lua](lua/core/plugins/debug.lua) |
| [nvim-dap-ui](https://github.com/rcarriga/nvim-dap-ui) | Debug UI | [debug.lua](lua/core/plugins/debug.lua) |
| [mason-nvim-dap.nvim](https://github.com/jay-babu/mason-nvim-dap.nvim) | Auto-install debug adapters | [debug.lua](lua/core/plugins/debug.lua) |
| [nvim-dap-go](https://github.com/leoluz/nvim-dap-go) | Go debugging | [debug.lua](lua/core/plugins/debug.lua) |
| [nvim-dap-python](https://github.com/mfussenegger/nvim-dap-python) | Python debugging | [debug.lua](lua/core/plugins/debug.lua) |

**Debug Adapters**:

- **C/C++/Rust**: codelldb
- **Python**: debugpy
- **Go**: delve
- **JavaScript/Node**: node2

**Debug Controls**:

- `F5`: Start/Continue, `F10`: Step over, `F11`: Step into, `F12`: Step out
- `<leader>db`: Toggle breakpoint, `<leader>dB`: Conditional breakpoint

### 💻 Terminal Integration

| Plugin | Purpose | Configuration |
|--------|---------|---------------|
| [toggleterm.nvim](https://github.com/akinsho/toggleterm.nvim) | Terminal management | [terminal.lua](lua/core/plugins/terminal.lua) |

**Terminal Features**:

- `<C-\>`: Toggle floating terminal
- Configured terminals: Python REPL, Node REPL, htop
- Layout options: floating, horizontal, vertical

### 🛠️ Utility Plugins

| Plugin | Purpose | Configuration |
|--------|---------|---------------|
| [which-key.nvim](https://github.com/folke/which-key.nvim) | Key binding hints | [utilities.lua](lua/core/plugins/utilities.lua) |
| [guess-indent.nvim](https://github.com/NMAC427/guess-indent.nvim) | Auto-detect indentation | [utilities.lua](lua/core/plugins/utilities.lua) |
| [todo-comments.nvim](https://github.com/folke/todo-comments.nvim) | TODO highlighting | [utilities.lua](lua/core/plugins/utilities.lua) |
| [nvim-bqf](https://github.com/kevinhwang91/nvim-bqf) | Better quickfix | [editor.lua](lua/core/plugins/editor.lua) |

## 🚀 Installation & Setup

### Prerequisites

**Essential Tools:**

```bash
# Core requirements
neovim >= 0.10.0
git
gcc/clang (C compiler)
make
ripgrep (rg)
fd-find

# Language-specific (optional)
node.js + npm     # For JS/TS support
python3 + pip     # For Python support
rust + cargo      # For Rust and building tools
```

**Recommended:**

- [Nerd Font](https://www.nerdfonts.com/) for icons (JetBrainsMono Nerd Font recommended)
- System clipboard tool (xclip/xsel/win32yank)

### Quick Installation

**Linux/macOS:**

```bash
# Backup existing configuration
mv ~/.config/nvim ~/.config/nvim.backup

# Clone repository
git clone https://github.com/IvoBrandao/nvim.git ~/.config/nvim

# Run setup script (installs dependencies)
cd ~/.config/nvim && ./scripts/setup.sh

# Launch Neovim (plugins install automatically)
nvim
```

**Windows:**

```powershell
# Backup existing configuration
Move-Item $env:LOCALAPPDATA\nvim $env:LOCALAPPDATA\nvim.backup

# Clone repository
git clone https://github.com/IvoBrandao/nvim.git $env:LOCALAPPDATA\nvim

# Launch Neovim
nvim
```

### Post-Installation

1. **Health Check**: `:checkhealth` verifies setup
2. **Tool Installation**: `:Mason` installs language tools
3. **Plugin Status**: `:Lazy` displays plugin installation status
4. **Plugin Updates**: `:Lazy sync` updates plugins

## ⌨️ Key Bindings Reference

**Leader Key**: `<Space>`

### 📁 File Operations

| Key | Action | Description |
|-----|--------|-------------|
| `<leader>e` | Toggle Neo-tree | File explorer |
| `<leader>ff` | Find files | Telescope file finder |
| `<C-p>` | Quick find | Fast file search |
| `<leader>fr` | Recent files | Recently opened files |
| `<leader>sg` | Live grep | Search in files |
| `<leader>sw` | Search word | Search current word |

### 🔧 Code Actions

| Key | Action | Description |
|-----|--------|-------------|
| `gd` | Go to definition | Jump to symbol definition |
| `gr` | Find references | Find all references |
| `K` | Hover docs | Show documentation |
| `<leader>ca` | Code action | Available code actions |
| `<leader>rn` | Rename | Rename symbol |
| `<leader>cf` | Format | Format current file |
| `<leader>cl` | Lint | Run linter on file |

### 🐛 Debugging

| Key | Action | Description |
|-----|--------|-------------|
| `F5` | Start/Continue | Begin or continue debugging |
| `F10` | Step over | Execute current line |
| `F11` | Step into | Enter function calls |
| `<leader>db` | Toggle breakpoint | Set/remove breakpoint |
| `F7` | Toggle UI | Show/hide debug interface |

### 🔄 Git Operations

| Key | Action | Description |
|-----|--------|-------------|
| `<leader>gg` | Lazygit | Full git interface |
| `<leader>gh` | Git history | View file/repo history |
| `]c` / `[c` | Navigate hunks | Next/previous changes |
| `<leader>hs` | Stage hunk | Stage current change |
| `<leader>hp` | Preview hunk | Preview change |

## 🎨 Customization Guide

### Adding Custom Plugins

Edit `lua/custom/plugins/init.lua`:

```lua
return {
  {
    'username/plugin-name',
    config = function()
      require('plugin-name').setup({
        -- Configuration options
      })
    end,
  },
  -- Additional plugins
}
```

### Changing Color Scheme

Different themes can be enabled by editing `lua/core/plugins/colorscheme.lua`. Available options:

- OneDark Pro (current)
- Kanagawa
- TokyoNight
- Catppuccin
- Gruvbox

### Modifying LSP Settings

LSP settings are modified by editing `lua/core/plugins/lsp.lua`:

- Language servers are added to the `servers` table
- Server-specific settings are configured
- Tools are added to the `ensure_installed` list

### Customizing Key Bindings

- **Global mappings**: Edit `init.lua`
- **Plugin-specific**: Edit the respective plugin file in `lua/core/plugins/`
- **LSP mappings**: Modify the LSP attach function in `lsp.lua`

## 🔍 Troubleshooting

### Common Issues

**Plugins not installing:**

```vim
:Lazy sync
:Lazy clean
```

**LSP not working:**

```vim
:LspInfo          " Check LSP status
:Mason            " Install missing servers
:checkhealth lsp  " Diagnose issues
```

**Slow startup:**

```vim
:Lazy profile     " Profile startup time
```

### Performance Optimization

- **Large files**: Treesitter disables automatically on files >100KB
- **Memory usage**: Lazy loading is configured for performance
- **Startup time**: Plugins load only when required

## 📚 Resources & Documentation

### Learning Neovim

- [Official Neovim docs](https://neovim.io/doc/)
- Built-in tutorial: `:Tutor`
- Help system: `:help <topic>`

### Understanding This Config

- `init.lua` contains the main configuration with comments
- `lua/core/plugins/` contains documented plugin configurations
- `:help <plugin-name>` provides plugin-specific documentation

### Plugin Documentation

- `:help lazy.nvim` - Plugin manager
- `:help telescope.nvim` - Fuzzy finder
- `:help lspconfig` - LSP configuration
- `:help nvim-dap` - Debugging

## 🙏 Acknowledgments

This configuration builds upon open-source projects:

- [lazy.nvim](https://github.com/folke/lazy.nvim) by folke
- [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) by the Neovim team
- [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) by nvim-telescope
- Inspired by [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim)

## 📄 License

MIT License - Configuration may be forked, modified, and used as needed.

---

**Happy Coding! 🚀**

# Run automated setup (installs tools and dependencies)

cd ~/.config/nvim
./scripts/setup.sh

# Start Neovim - plugins will auto-install

nvim

```

**Windows (PowerShell):**

```powershell
# Backup existing config
Move-Item $env:LOCALAPPDATA\nvim $env:LOCALAPPDATA\nvim.backup

# Clone this repository
git clone <your-repo-url> $env:LOCALAPPDATA\nvim

# Start Neovim - plugins will auto-install
nvim
```

### Manual Installation

If you prefer manual setup or the automated script doesn't work for your system:

1. **Install Neovim** (version 0.10+)
   - Ubuntu: `sudo apt install neovim` or use AppImage
   - macOS: `brew install neovim`
   - Windows: Download from [neovim.io](https://neovim.io/)

2. **Install basic tools:**

   ```bash
   # Ubuntu/Debian
   sudo apt install git gcc make ripgrep fd-find xclip

   # macOS
   brew install git gcc make ripgrep fd

   # Arch
   sudo pacman -S git gcc make ripgrep fd
   ```

3. **Clone this config:**

   ```bash
   git clone <your-repo-url> ~/.config/nvim
   ```

4. **Launch Neovim:**

   ```bash
   nvim
   ```

   Plugins will install automatically via lazy.nvim.

## 📚 Language Support

Each language has LSP, formatting, and linting configured:

| Language | LSP Server | Formatter | Linter |
|----------|-----------|-----------|--------|
| C/C++ | clangd | clang-format | clang-tidy |
| Rust | rust_analyzer | rustfmt | clippy |
| Python | pyright | black + isort | pylint + mypy |
| TypeScript/JS | ts_ls | prettier | eslint_d |
| HTML | html | prettier | - |
| CSS | cssls | prettier | - |
| Lua | lua_ls | stylua | - |
| Markdown | marksman | prettier | markdownlint |
| JSON | jsonls | prettier | jsonlint |
| YAML | yamlls | prettier | yamllint |
| VHDL | vhdl_ls | - | - |
| Verilog | verible | - | - |

Additional tools (shellcheck, hadolint for Dockerfiles) are also configured.

## ⌨️ Key Bindings

**Leader key:** `Space`

### File Operations

| Key | Action |
|-----|--------|
| `<leader>e` | Toggle file explorer |
| `<leader>ff` | Find files |
| `Ctrl+p` | Quick file search |
| `<leader>fg` | Find git files |
| `<leader>fr` | Recent files |
| `<leader>sg` | Live grep (search in files) |
| `<leader>sw` | Search word under cursor |

### Buffer Navigation

| Key | Action |
|-----|--------|
| `Shift+h` | Previous buffer |
| `Shift+l` | Next buffer |
| `<leader>bd` | Delete buffer |
| `<leader><leader>` | Find buffers |

### Window Management

| Key | Action |
|-----|--------|
| `Ctrl+h/j/k/l` | Navigate windows |
| `Ctrl+↑/↓/←/→` | Resize windows |
| `Ctrl+s` | Save file |

### Code Actions

| Key | Action |
|-----|--------|
| `gd` | Go to definition |
| `gr` | Find references |
| `gI` | Go to implementation |
| `K` | Hover documentation |
| `<leader>ca` | Code action |
| `<leader>rn` | Rename symbol |
| `<leader>cf` | Format code |
| `<leader>cl` | Lint file |

### Git

| Key | Action |
|-----|--------|
| `<leader>gg` | Open lazygit |
| `<leader>gh` | Git history (diffview) |
| `]c` / `[c` | Next/previous hunk |
| `<leader>hs` | Stage hunk |
| `<leader>hr` | Reset hunk |
| `<leader>hp` | Preview hunk |
| `<leader>hb` | Blame line |

### Debugging

| Key | Action |
|-----|--------|
| `F5` | Continue/Start |
| `F10` | Step over |
| `F11` | Step into |
| `F12` | Step out |
| `<leader>db` | Toggle breakpoint |
| `<leader>dB` | Conditional breakpoint |
| `<leader>dr` | Open REPL |

### Terminal

| Key | Action |
|-----|--------|
| `Ctrl+\` | Toggle terminal |
| `<leader>tf` | Float terminal |
| `<leader>th` | Horizontal terminal |
| `<leader>tv` | Vertical terminal |

### Other

| Key | Action |
|-----|--------|
| `Ctrl+d` | Multi-cursor (like VSCode) |
| `Alt+j/k` | Move line up/down |
| `]t` / `[t` | Next/previous TODO comment |
| `<leader>st` | Search TODOs |

## 🎨 Customization

### Adding Your Own Plugins

Add plugins to `lua/custom/plugins/init.lua`:

```lua
return {
  {
    'your-name/your-plugin',
    config = function()
      require('your-plugin').setup({
        -- Your configuration
      })
    end,
  },
}
```

### Changing Color Scheme

Edit `lua/core/plugins/colorscheme.lua`. Uncomment one of the alternative themes (TokyoNight, Catppuccin, Gruvbox) or add your own.

### Modifying Keybindings

Keybindings are defined in:

- `init.lua` - Global keybindings
- Individual plugin files - Plugin-specific keybindings

### Adjusting LSP Servers

Edit `lua/core/plugins/lsp.lua` to add/remove language servers or change their configuration.

## 🔍 Health Check

After installation, run health check to verify everything:

```vim
:checkhealth
```

This will show:

- Neovim version
- Provider status (Python, Node, Ruby)
- External tool availability
- Plugin status

## 🛠️ Troubleshooting

### Plugins Not Installing

```vim
:Lazy sync
```

### LSP Server Not Working

1. Check if server is installed: `:Mason`
2. Install missing servers: `:MasonInstall <server-name>`
3. Check LSP status: `:LspInfo`

### Formatter Not Working

1. Check if formatter is installed: `:Mason`
2. Manually format: `<leader>cf`
3. Check conform status: `:ConformInfo`

### Performance Issues

- Large files: TreeSitter may slow down. Disable with `:TSBufDisable highlight`
- Many plugins: Review `lua/core/plugins/` and disable unwanted ones
- Startup time: Run `:Lazy profile` to identify slow plugins

## 📖 Learning Resources

### Neovim

- [Neovim Documentation](https://neovim.io/doc/)
- [Learn Vim Inside Vim](https://github.com/iggredible/Learn-Vim): `:Tutor`

### This Configuration

- Read `init.lua` - Main configuration file
- Explore `lua/core/plugins/` - Each file is extensively commented
- Check `:help` for any command or setting

### Plugins

Each plugin has detailed documentation:

- `:help lazy.nvim` - Plugin manager
- `:help telescope.nvim` - Fuzzy finder
- `:help lspconfig` - LSP configuration
- And more...

## 🙏 Credits

This configuration is built on top of:

- [lazy.nvim](https://github.com/folke/lazy.nvim) - Plugin manager
- [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) - LSP configurations
- [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) - Treesitter integration

Inspired by the original [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim) project.

## 📝 License

MIT License - See [LICENSE.md](LICENSE.md) for details.

## 🤝 Contributing

This is a personal configuration, but feel free to:

- Fork and customize for your needs
- Suggest improvements
- Share your own configuration ideas

## 📮 Support

- Check `:checkhealth` for diagnostics
- Review plugin documentation with `:help <plugin-name>`
- Search issues in respective plugin repositories
- Consult Neovim documentation: `:help`

---
