#!/usr/bin/env bash
set -euo pipefail

# Script to update plugins using headless Neovim (lazy.nvim) and prepare git changes.
# Usage: ./scripts/update-plugins.sh

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$REPO_ROOT"

echo "Running headless Neovim to update plugins..."

# Run Lazy update in headless mode. Use a quiet invocation so this is safe in CI.
# We tolerate failure of the update command itself (network, build steps) so the
# script can still check for repository changes afterwards.
if ! nvim --headless -u init.lua -c 'silent! Lazy update' -c 'qa' ; then
  echo "Warning: 'Lazy update' returned non-zero exit code. Continue to check for changes."
fi

# If no changes, exit cleanly
if git status --porcelain --ignore-submodules --untracked-files=no | grep -q .; then
  BRANCH="automated/plugin-updates-$(date +%Y%m%d-%H%M%S)"
  echo "Changes detected. Creating branch $BRANCH, committing and pushing to origin..."

  git checkout -b "$BRANCH"
  git add -A
  git commit -m "chore: automated plugin updates"

  # Push branch
  if git remote get-url origin >/dev/null 2>&1; then
    git push -u origin "$BRANCH"
  else
    echo "No 'origin' remote configured; commit created locally on branch $BRANCH."
    exit 0
  fi

  # Try to open a PR using gh if available
  if command -v gh >/dev/null 2>&1; then
    echo "Creating pull request using GitHub CLI..."
    gh pr create --title "Automated plugin updates" --body "This PR updates lazy.nvim plugins and lockfile." --base master --head "$BRANCH"
  else
    echo "Pushed branch $BRANCH to origin."
    echo "Install and authenticate GitHub CLI (gh) to open a PR automatically, or create one at:"
    echo "https://github.com/<OWNER>/<REPO>/compare/$BRANCH?expand=1"
  fi
else
  echo "No changes after running Lazy update. Nothing to do."
fi
