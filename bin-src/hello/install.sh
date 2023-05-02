#!/bin/sh

set -e

(
  cargo build

  from_path="$(realpath "$(dirname "$0")/target/debug/hello")"
  to_path="$HOME/.local/bin/hello"

  ln -sf "$from_path" "$to_path"
)
