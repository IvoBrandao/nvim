#!/usr/bin/env bash
set -euo pipefail

# macOS setup script for Neovim + tooling needed by this config

echo "Checking for Homebrew..."
if ! command -v brew >/dev/null 2>&1; then
  echo "Homebrew not found. Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  eval "$(/opt/homebrew/bin/brew shellenv)" || true
fi

echo "Updating brew..."
brew update || true

echo "Installing packages via brew..."
brew install neovim git ripgrep fd node python ruby rust tree-sitter pkg-config cmake openjdk gh php composer || true

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

echo "Run headless Neovim to install plugins and build native modules..."
REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$REPO_ROOT"

if command -v nvim >/dev/null 2>&1; then
  nvim --headless -u init.lua -c 'silent! Lazy sync' -c 'qa' || true
else
  echo "Neovim not found in PATH after installation; please verify installation." >&2
fi

echo "macOS setup completed. Re-run ':checkhealth' in Neovim to verify warnings are resolved."
echo
echo "NOTE: Some packages were installed to user locations. If you used --user installs, make sure the following are in your PATH (add to ~/.zshrc or shell rc):"
echo "  - Python user binaries: export PATH=\"$HOME/.local/bin:\$PATH\""
echo "  - Ruby user gem binaries: export PATH=\"$(ruby -r rubygems -e 'print Gem.user_dir')/bin:\$PATH\""
echo "  - Rust (cargo) binaries: export PATH=\"$HOME/.cargo/bin:\$PATH\""

# Provider checks: verify providers and auto-install missing ones.
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

# Node provider
if command -v npm >/dev/null 2>&1; then
  if ! npm list -g --depth=0 neovim >/dev/null 2>&1; then
    echo "npm neovim package not found; installing globally..."
    npm install -g neovim || true
  else
    echo "npm neovim package already installed"
  fi
fi

# Ruby provider
if ruby -e "begin; require 'neovim'; puts 'ok'; rescue LoadError; exit 1; end" >/dev/null 2>&1; then
  echo "Ruby neovim gem available"
else
  echo "Installing neovim Ruby gem (user install)"
  gem install --user-install neovim || true
fi

# Ensure PATH entries are present in shell rc files (zshrc/profile)
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

ensure_path_line "$PY_BIN_LINE" "$HOME/.zprofile"
ensure_path_line "$RUBY_BIN_LINE" "$HOME/.zprofile"
ensure_path_line "$RUST_BIN_LINE" "$HOME/.zprofile"

ensure_path_line "$PY_BIN_LINE" "$HOME/.zshrc"
ensure_path_line "$RUBY_BIN_LINE" "$HOME/.zshrc"
ensure_path_line "$RUST_BIN_LINE" "$HOME/.zshrc"

echo "Provider checks complete. You may need to restart your shell for PATH changes to take effect."
