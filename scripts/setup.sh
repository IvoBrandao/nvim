#!/usr/bin/env bash
set -euo pipefail

# Wrapper that detects OS and runs the appropriate setup script.
DIR="$(cd "$(dirname "$0")" && pwd)"

uname_s=$(uname -s)
case "$uname_s" in
  Linux*)
    echo "Detected Linux; running Ubuntu setup script"
    bash "$DIR/setup-ubuntu.sh"
    ;;
  Darwin*)
    echo "Detected macOS; running macOS setup script"
    bash "$DIR/setup-macos.sh"
    ;;
  *)
    echo "Unsupported OS: $uname_s" >&2
    exit 2
    ;;
esac
