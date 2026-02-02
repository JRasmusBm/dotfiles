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
./scripts/symlink
```

Existing non-symlink files are backed up to `~/.backup_dotfiles/` before being replaced.
