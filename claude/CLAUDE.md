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
  Speed-dial entries (above the first heading — a `# Foo` or
  `Foo:` line — in the order file) are hidden, they're on
  Alt-N already. Worktrees under a heading show as
  `HEADING: branch`; on-disk worktrees not on the board show
  as `⊘ branch`. Selecting either opens its tmux session;
  picking an orphan also offers to adopt it onto the board.
- `wt add <branch>` — create worktree + register
- `wt fix <url|text>` / `wt feat <url|text>` — Linear-aware
  add. A Linear issue URL becomes
  `<type>/${WT_INITIALS:-jrb}/<id>-<slug>` (id + slug parsed
  straight from the URL, no token); free text is slugified
  to `<type>/<initials>/<slug>`. The `fix`/`feat` prefix
  comes from the command name. E.g. `wt fix
  linear.app/x/issue/POL-1527/deleting-connections-…` →
  branch `fix/jrb/pol-1527-deleting-connections-…`.
  After creating the worktree it opens the tmux session and,
  for a Linear URL, kicks off a Claude session in the third
  window (`cli`) preloaded with a prompt: `fix` →
  "Can you please fix <url>? Please also examine the video
  and the images"; `feat` → "Can you please read <url> and
  relative feature docs? Then please grill me on the
  solution." Generic (not per-repo) — relies on the default
  run/vim/cli layout worktrees get with no `.tmux`. The
  session is named `<repo>[<line>]` (the order-file row it
  landed on, the Alt-N speed-dial convention) — not the
  branch slug — so `wt fix`/`feat` and a later Alt-N attach
  to the *same* session instead of spawning a duplicate.
- `wt rt` / `wt rp` — park the current worktree for review:
  move its board entry into the `# TEAM REVIEW` (`rt`) or
  `# PROD REVIEW` (`rp`) section (reusing a freed slot there,
  else adding a new line; creates the heading if missing) and
  kill its tmux session — but keep the checkout + branch
  (PR's still open). Frees a speed-dial slot + session for
  new tickets. Reachable again via `wt :` (shown as
  `TEAM REVIEW: branch` / `PROD REVIEW: branch`). Unlike
  `wt rm`, nothing is removed or registered.
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
default branch; each later line up to the first heading
(`# Foo`/`Foo:`) = a speed-dial slot (Alt-N). `add`/`fix`/
`feat` insert into the first freed speed-dial slot if one's
open, else append to the `# IN PROGRESS` section (reusing a
freed slot there, else a new line at the section's end) —
never spilling into a later section's blank or the file
tail. Removed entries are blanked (not deleted) to keep slot
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

## Linear

`lin o` (or just `lin`) — open the current branch's Linear
ticket in the browser. Parses the identifier from the branch
(e.g. `fix/jrb/pol-1527-…` → `POL-1527`) and opens
`linear.app/<workspace>/issue/<ID>` (slug-less; Linear
redirects to the full ticket). Workspace defaults to
`polaranalytics-new`, override with `$LINEAR_WORKSPACE`.
Pairs with `wt fix`/`wt feat`, which embed the id in the
branch name.

## Notifications

A persistent inbox so notifications don't just flash and
vanish. Every notifier funnels through `bin/notify`
(Claude's hook via `claude-notify`, `git-w8`, `bw8`, …), so
`notify` is the one chokepoint: alongside the macOS toast +
sound + tmux bell it appends a row to
`$LOCAL_CONFIG/notifications`
(`epoch<TAB>session:window<TAB>title<TAB>message`), capturing
the calling pane's `#S:#W` as the place to jump back to.

- `M-i` (tmux) / `notif next` — jump straight to the *oldest*
  pending notification (FIFO), no picker.
- `M-o` (tmux) / `notif` — pop a temp pane with an fzf list,
  collapsed to one row per place (latest message + `×N`
  count, newest first); `<Enter>` jumps to that
  session:window.
- A counter badge (`#(notif count)` → `✉N`, count of distinct
  pending places) sits in `status-right` before the date.
  `notify` and `notif seen` call `refresh-client -S` so it
  updates the moment a notification lands or clears.
- Clearing is keyed on **arriving** at the place, not on any
  Enter: the focus/nav hooks (`pane-focus-in`,
  `client-session-changed`, `after-select-window`) run
  `notif seen "#{session_name}:#{window_name}"`, so reaching
  a place *any* way (M-i, M-o, speed-dial, `wt :`, manual
  nav, mouse) clears its entries.
- `notif seen <ctx>` — drop a context's rows (hook-driven;
  fast no-op when nothing matches). `notif count` — badge.
  `notif clear` — empty it.

`bin/notify` only appends (atomic single-line `>>`, safe
across concurrent Claude sessions); the dedup/count happens
at view time in `bin/notif`.

## Git

Use `g s <branch>` to switch branches (not raw
`git switch`). The `git-s` wrapper refreshes the
tmux status bar after switching.
