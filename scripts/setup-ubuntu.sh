#!/usr/bin/env bash
set -euo pipefail

# Ubuntu setup script for Neovim + tooling needed by this config
# Runs as root or via sudo when required.

if [ "$(id -u)" -ne 0 ]; then
  SUDO=sudo
else
  SUDO=""
fi

echo "Updating apt repositories..."
$SUDO apt-get update -y

echo "Installing core packages..."
$SUDO apt-get install -y \
  git curl wget build-essential unzip ca-certificates \
  neovim ripgrep fd-find xclip pkg-config cmake python3 python3-pip \
  nodejs npm ruby-full openjdk-17-jdk npm \
  unzip

# fd-find installs as fdfind on Debian/Ubuntu; create a symlink if necessary
if ! command -v fd >/dev/null 2>&1; then
  if command -v fdfind >/dev/null 2>&1; then
    echo "Creating /usr/local/bin/fd -> fdfind"
    $SUDO ln -sf "$(command -v fdfind)" /usr/local/bin/fd
  fi
fi

echo "Installing Rust toolchain (for building native extensions)..."
if ! command -v cargo >/dev/null 2>&1; then
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
  export PATH="$HOME/.cargo/bin:$PATH"
fi

echo "Installing tree-sitter CLI (via cargo)..."
if command -v cargo >/dev/null 2>&1; then
  cargo install tree-sitter-cli --locked || true
fi

echo "Installing Python neovim host package..."
python3 -m pip install --user pynvim || true

echo "Installing npm neovim package..."
if command -v npm >/dev/null 2>&1; then
  if ! npm list -g --depth=0 neovim >/dev/null 2>&1; then
    npm install -g neovim || true
  else
    echo "npm neovim package already installed globally"
  fi
fi

echo "Installing Ruby neovim gem..."
gem install --user-install neovim || true

echo
echo "NOTE: Some packages were installed to user locations. If you used --user installs, make sure the following are in your PATH (add to ~/.profile or shell rc):"
echo "  - Python user binaries: export PATH=\"$HOME/.local/bin:\$PATH\""
echo "  - Ruby user gem binaries: export PATH=\"$(ruby -r rubygems -e 'print Gem.user_dir')/bin:\$PATH\""
echo "  - Rust (cargo) binaries: export PATH=\"$HOME/.cargo/bin:\$PATH\""
echo

# Provider checks: verify providers are usable and attempt auto-fix if missing.
echo "Checking Neovim providers and auto-installing missing pieces..."

# Python provider
if python3 -c "import importlib,sys
try:
    importlib.import_module('pynvim')
    sys.exit(0)
except Exception:
    sys.exit(1)
"; then
  echo "Python neovim package (pynvim) is present"
else
  echo "pynvim not found; installing via pip --user..."
  python3 -m pip install --user pynvim || true
fi

# Node provider (neovim npm package)
if command -v npm >/dev/null 2>&1; then
  if ! npm list -g --depth=0 neovim >/dev/null 2>&1; then
    echo "npm neovim package not found; installing globally..."
    npm install -g neovim || true
  else
    echo "npm neovim package already installed"
  fi
fi

# Ruby provider (neovim gem)
if ruby -e "begin; require 'neovim'; puts 'ok'; rescue LoadError; exit 1; end" >/dev/null 2>&1; then
  echo "Ruby neovim gem available"
else
  echo "Installing neovim Ruby gem (user install)"
  gem install --user-install neovim || true
fi

# Ensure PATH entries are present in common shell rc files
ensure_path_line() {
  local line="$1"
  local file="$2"
  if [ -f "$file" ]; then
    if ! grep -Fq "$line" "$file"; then
      echo "$line" >> "$file"
      echo "Appended PATH line to $file"
    fi
  else
    echo "$line" >> "$file"
    echo "Created $file and added PATH line"
  fi
}

PY_BIN_LINE='export PATH="$HOME/.local/bin:$PATH"'
RUBY_BIN_LINE="export PATH=\"$(ruby -r rubygems -e 'print Gem.user_dir')/bin:$PATH\""
RUST_BIN_LINE='export PATH="$HOME/.cargo/bin:$PATH"'

ensure_path_line "$PY_BIN_LINE" "$HOME/.profile"
ensure_path_line "$RUBY_BIN_LINE" "$HOME/.profile"
ensure_path_line "$RUST_BIN_LINE" "$HOME/.profile"

if [ -f "$HOME/.bashrc" ]; then
  ensure_path_line "$PY_BIN_LINE" "$HOME/.bashrc"
  ensure_path_line "$RUBY_BIN_LINE" "$HOME/.bashrc"
  ensure_path_line "$RUST_BIN_LINE" "$HOME/.bashrc"
fi

echo "Provider checks complete. You may need to restart your shell for PATH changes to take effect."

echo "Installing Composer (PHP) - optional"
if ! command -v composer >/dev/null 2>&1; then
  # install php-cli and composer
  $SUDO apt-get install -y php-cli php-zip unzip
  EXPECTED_SIGNATURE=$(curl -s https://composer.github.io/installer.sig)
  php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
  php -r "if (hash_file('SHA384', 'composer-setup.php') === '$EXPECTED_SIGNATURE') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); exit(1); }"
  php composer-setup.php --install-dir=/usr/local/bin --filename=composer
  php -r "unlink('composer-setup.php');"
fi

echo "Optional: Installing GitHub CLI (gh) if available from apt..."
if ! command -v gh >/dev/null 2>&1; then
  # Try GitHub CLI apt repo
  curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | $SUDO dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
  $SUDO chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg
  echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | $SUDO tee /etc/apt/sources.list.d/github-cli.list > /dev/null
  $SUDO apt update -y
  $SUDO apt install -y gh || true
fi

echo "Run headless Neovim to install plugins and build native modules..."
# Use the repository's init.lua; run Lazy sync to install and build plugins
REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$REPO_ROOT"

if command -v nvim >/dev/null 2>&1; then
  nvim --headless -u init.lua -c 'silent! Lazy sync' -c 'qa' || true
else
  echo "Neovim not found in PATH after installation; please verify installation." >&2
fi

echo "Ubuntu setup completed. Re-run ':checkhealth' in Neovim to verify warnings are resolved."
