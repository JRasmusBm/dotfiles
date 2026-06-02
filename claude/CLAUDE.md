# Personal Preferences

At conversation end, propose CLAUDE.md updates if patterns discovered.
Only write to auto memory for cross-project notes.
Per-project knowledge goes in repo CLAUDE.md or related skills/docs where it
can be committed and shared.

## Identity

Initials: jrb.
Name: Rasmus Bergström.
Tools: Neovim, Zsh, Alacritty, macOS, Hammerspoon.

## Working Style

Be proactive, not permission-seeking. Make changes first, ask later.
Don't ask "Want me to do X?" — just do it.

## Questions

Prefer AskUserQuestion with options over plain text
questions. Easier to pick + annotate a 90% correct
suggestion than retype from scratch.

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

## Platform Quirks

macOS ships BSD awk. Use `gawk` for GNU awk features.

## CLI Conventions

- No args = sane default (help or primary action)
- `:` = fuzzy find
- `.` = current context (branch/issue/worktree)
- Explicit arg = use directly

## Worktree Workflow

Worktrees at `${repo}/.worktrees/${branch}`. Managed via `wt`:
- `wt .`/`rm`/`remove` — remove the checkout AND delete the
  branch, but pin `refs/wt/<slug>` + log to the registry
  first, so it's fully reversible via resume. Reclaims GBs.
  `.` = current, `:` = fzf pick, or `<name>`.
- `wt :` — fzf pick worktree to switch to. Lists from disk
  (`git worktree list`), so it always reflects reality;
  preview (`wt-preview`) shows branch, last commit, PR state,
  and the first prompt of the worktree's last AI session.
  Speed-dial entries
  (above the first `FOO:` heading in the order file) are
  hidden — they're on Alt-N already. Worktrees under a
  heading show as `HEADING: branch`; on-disk worktrees not on
  the board show as `⊘ branch` and selecting one offers to
  adopt it.
- `wt add <branch>` — create worktree + register
- `wt clean [-f]` — remove every worktree (incl. orphans)
  whose PR is merged (via `gh`), confirming each; `-f` skips
  prompts
- `wt resume <slug>`/`:` — re-materialise a removed
  worktree at the same path (so `claude -r` finds its
  context). `:` opens the registry graveyard in fzf.
- `wt forget <slug>` — the only true destroy: drop branch
  + `refs/wt/<slug>` so it leaves the resurrectable set.
  Claude context dir left intact.
- `wt dedup` — reinstall across worktrees so Yarn relinks
  node_modules into the hardlinks-global store (run once
  after enabling `nmMode`)
- `wt move [branch]` — stash, create worktree, pop
- `wt e [repo]` — edit worktree order file

Order files at `$LOCAL_CONFIG/worktrees/<repo>`. Line 1 =
default branch; each later line = a speed-dial slot.
Removed entries are blanked (not deleted) to keep slot
indices stable for `wt-resolve`. No archiving — removing a
worktree drops it from the board into the registry, where
`wt resume` brings it back.

Removed worktrees append to `<repo>.registry` (append-only,
never blanked): `slug<TAB>branch<TAB>sha<TAB>date`. The
companion `refs/wt/<slug>` git ref pins the commit and
survives `git branch -D`, `fetch --prune`, and `gc` —
that's what makes `wt resume` reliable after branch cleanup.

Disk: `~/.yarnrc.yml` sets `nmMode: hardlinks-global` so
node_modules dedupes across worktrees via Yarn's global
content store. Removal is cheap because the checkout is
the only expensive, non-reconstructable-from-refs part.

Claude context is keyed by cwd path
(`~/.claude/projects/<escaped-path>/`), deterministic from
the worktree path. `wt rm` never touches it, so the context
outlives the checkout and `wt resume` lands you back on it.

Always use `wt` commands, never raw `git worktree add`.

## Git

Use `g s <branch>` to switch branches (not raw
`git switch`). The `git-s` wrapper refreshes the
tmux status bar after switching.
