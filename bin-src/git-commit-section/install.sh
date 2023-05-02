#!/bin/sh

set -e

(
  cargo build

  from_path="$(realpath "$(dirname "$0")/target/debug/git-commit-section")"
  to_path="$HOME/.local/bin/git-commit-section"

  ln -sf "$from_path" "$to_path"
)
