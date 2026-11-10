# Dotfiles

This repository manages configuration files (dotfiles) for various tools and applications.

## Setup Approach

Dotfiles are installed using **symlinks**. The `scripts/symlink` script reads `files.csv` and creates symbolic links from this repository to the appropriate locations in `$HOME`.

### Adding New Dotfiles

1. Add the configuration file to an appropriate directory in this repo
2. Add an entry to `files.csv` with three columns:
   - `is_dir`: `True` if symlinking an entire directory, `False` for individual files
   - `source`: path relative to repo root
   - `target`: path relative to `$HOME`

### Running the Symlink Script

```sh
sh scripts/symlink
```

Existing non-symlink files are backed up to `~/.backup_dotfiles/` before being replaced.

## Shipping

Agents merge their own PRs here and verify the result
live (installed scripts, launchd jobs, a real run) without
asking: the repo is my personal tooling, the merge is the
release, and waiting on me only stalls it. No CI runs on
PRs and `/iterate-review` doesn't exist in this setup, so
the hand-back bar is local tests plus that live check.

## Git Hooks

`--no-verify` is authorized for push/commit. The
`confirm` prompt requires `/dev/tty` which is
unavailable in Claude Code. It also skips `leak-check`
(this repo is public): run `leak-check --staged` before
such a commit.

## Skills

- **[private-overlay](claude/skills/private-overlay/SKILL.md)** (global) — What goes in public dotfiles vs the private overlay (`~/.private`), and the seams between them. Load before editing any skill, CLAUDE.md, script or setting.

- **[commit](.claude/skills/commit/SKILL.md)** — Create atomic commits from uncommitted changes. Groups related modifications into logical, self-contained commits.

## Tests

`tests/*.sh` run real tmux on throwaway servers. Unset `TMUX`
and `TMUX_PANE` before the first tmux call: tmux prefers the
socket in `$TMUX` over `TMUX_TMPDIR`, so a test's cleanup
`kill-server` otherwise kills the server the agent runs in.
After a run, check the real servers' pids are unchanged.
