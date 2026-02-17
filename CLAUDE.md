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

## Git Hooks

`--no-verify` is authorized for push/commit. The
`confirm` prompt requires `/dev/tty` which is
unavailable in Claude Code.

## Skills

- **[commit](.claude/skills/commit/SKILL.md)** — Create atomic commits from uncommitted changes. Groups related modifications into logical, self-contained commits.
