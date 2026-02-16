# Personal Preferences

At conversation end, propose CLAUDE.md updates if patterns discovered.

## Identity

Initials: jrb. Tools: Neovim, Zsh, Alacritty, macOS, Hammerspoon.

## Working Style

Be proactive, not permission-seeking. Make changes first, ask later.
Don't ask "Want me to do X?" — just do it.

## Communication

Extremely concise. Sacrifice grammar for concision.
When explaining: provide context + doc links.
When investigating: explain approach.
Voice typing: interpret phonetic errors from context
(cloud MD → CLAUDE.md, sim link → symlink, get hub → GitHub).

## Plans

Extremely concise. End with unresolved questions if any.

## Line Length — HARD LIMIT

ALL chat output MUST wrap at 80 chars — prose,
markdown tables, plans, explanations. No exceptions.
Break lines mid-sentence if needed.

Code edits: 80 chars unless the project has its own
style guide (e.g. prettier config).

## Dotfiles

Managed in ~/projects/dotfiles. Symlinked via scripts/symlink +
files.csv. Repo skills: .claude/skills/. Global skills:
~/projects/dotfiles/claude/skills/ (→ ~/.claude/skills/).
Never create config directly in target locations.

## Worktree Workflow

Worktrees at `${repo}/.worktrees/${branch}`. Managed via `wt`:
- `wt add <branch>` — create worktree + register in order file
- `wt rm [name]` — remove worktree + blank order file line
- `wt move [branch]` — stash, create worktree, pop
- `wt e [repo]` — edit worktree order file
- `wt archive/unarchive <name>` — move between sections

Order files at `$LOCAL_CONFIG/worktrees/<repo>`. Line 1 =
default branch. Blank line separates active/archived.

Always use `wt` commands, never raw `git worktree add`.

## Git

Use `g s <branch>` to switch branches (not raw
`git switch`). The `git-s` wrapper refreshes the
tmux status bar after switching.
