# Commit

Create atomic commits from uncommitted changes. Analyzes changes to group related modifications together into logical, self-contained commits.

## Process

### Research (read-only)

1. **Survey all changes** — Run `git status` and `git diff` to see what's uncommitted (staged and unstaged)

### Planning

2. **Analyze change relationships** — Look at file paths, content changes, and logical groupings
3. **Plan atomic commits** — Group changes that belong together:
   - Same feature or bugfix
   - Same area of the codebase
   - Dependent changes that only make sense together

### Execution

4. **Create commits** — Stage and commit each group with a clear message

## Grouping Heuristics

Changes likely belong together if they:
- Are for the same tool (vim, shell, git, etc.)
- Are part of the same feature (e.g., new alias + shell config for it)
- Include both config and symlink entry in files.csv
- Would break something if committed separately

Changes should be separate if they:
- Configure different tools
- Could be reverted independently
- Are unrelated quality-of-life tweaks

## Commit Messages

- Use conventional commit format when appropriate (feat:, fix:, refactor:, docs:, etc.)
- Keep the subject line under 50 characters
- Focus on the "what" and "why", not the "how"
- Reference issue numbers if apparent from the code

## Execution

- Use `--no-verify` flag to bypass pre-commit hooks (trusted context)
- Stage files explicitly by name, not with `-A` or `.`
- After each commit, verify with `git log --oneline -1`
- Run scripts with `sh script` rather than trying to execute directly (symlinks may lack execute permissions)

## Example

Given changes to:
- `vim/vimrc` (new keybinding)
- `vim/lua/plugins.lua` (new plugin for the keybinding)
- `shell/zshrc` (new alias)
- `git/gitconfig` (change default branch name)
- `files.csv` (add new skill to symlinks)
- `claude/skills/foo/SKILL.md` (new skill)

Creates four commits:
1. `feat(vim): add keybinding for X` — vimrc + plugins.lua
2. `feat(shell): add alias for Y` — zshrc
3. `fix(git): change default branch to main` — gitconfig
4. `feat(claude): add foo skill` — files.csv + skills/foo/SKILL.md
