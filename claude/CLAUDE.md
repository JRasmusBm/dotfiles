# Personal Preferences

At conversation end, propose CLAUDE.md/skill updates if patterns
discovered. Before that reflection, and before editing any skill or
CLAUDE.md, load the repo's `save-learnings` skill if it has one.
Only write to auto memory for cross-project notes.
Per-project knowledge goes in repo CLAUDE.md or related skills/docs where it
can be committed and shared.

## Identity

Initials: jrb.
Name: Rasmus Bergström.
Tools: Neovim, Zsh, Alacritty, macOS, Hammerspoon.

## Working Style

Be proactive, not permission-seeking. Make changes first, ask later.
Don't ask "Want me to do X?" — just do it. Includes my PRs: push
to the branch and keep the title/body in sync without asking.

Replace, don't accrete. Rewrite what's there, don't append beside it.
Adding lines? Name what they replace.

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
  `.` = current, `:` = fzf pick, or `<name>` — a branch
  or worktree dir (slug), resolved via `git worktree
  list`; no match = error. Prints what it's removing;
  the delete itself runs in the background. Then runs the
  repo's trusted `.jrb/wt-hook rm <slug>` (ice-floe: `penv
  free`, releasing the worktree's ports); `forget` runs it
  with `forget` (`penv rm`).
- `wt :` — fzf pick worktree to switch to. Lists from disk
  (`git worktree list`), so it always reflects reality;
  preview (`wt-preview`) shows branch, last commit, PR state,
  and the first prompt of the worktree's last AI session.
  Worktrees under a heading (a `# Foo` or `Foo:` line in the
  order file) show as `HEADING: branch`, on-disk worktrees
  not on the board as `⊘ branch`. Selecting one opens its
  session (named by slug, like every entry point); picking
  an orphan also offers to adopt it onto the board.
- `wt add <branch>` — create worktree + register
- `wt fix <url|text>` / `wt feat <url|text>` — Linear-aware
  add. A Linear issue URL becomes
  `<type>/${WT_INITIALS:-jrb}/<id>-<slug>` (id + slug parsed
  straight from the URL, no token, any team key — `EXP-`,
  `PLA-`, …); a Linear project URL becomes
  `<type>/<initials>/<slug>` (the trailing 12-hex slug id
  dropped); free text is slugified to
  `<type>/<initials>/<slug>`. The `fix`/`feat` prefix
  comes from the command name. E.g. `wt fix
  linear.app/x/issue/EXP-1527/deleting-connections-…` →
  branch `fix/jrb/exp-1527-deleting-connections-…`.
  After creating the worktree it opens the tmux session and,
  for a Linear URL, kicks off a Claude session in the third
  window (`cli`) preloaded with a prompt: `fix` →
  "Can you please fix <url>? Please also examine the video
  and the images"; `feat` → "Can you please read <url> and
  relative feature docs? Then please grill me on the
  solution."; a project URL (either command) gets the feat
  prompt, widened to the project's overview, documents,
  milestones and issues. Generic (not per-repo) — relies on
  the default run/vim/cli layout worktrees get with no `.tmux`.
  `WT_PROMPT_EXTRA="…"` appends to the kickoff prompt;
  `WT_NO_ATTACH=1` skips attaching (batch kickoffs from
  Claude). Prompt avoids `"`, `$`, backticks.
- `wt review [<pr>|<pr-url>|<branch>]` — review somebody
  else's work. No arg (or `:`) fzf-picks an open PR that
  isn't mine (`gh pr list --search -author:@me`); a bare
  number or a PR URL resolves through `gh`; anything else
  is taken as a branch name. Their branch usually isn't
  local yet, so it always fetches first — `refs/pull/<n>/
  head` for a PR (so fork PRs work too), else the branch
  from `origin` — then creates the worktree (tracking
  `origin/<branch>` when that exists, else pinned to the
  fetched sha), puts it on the board exactly like `add`,
  and opens a Claude session prompted to give (1) a
  recommended approach to the review — what to read first,
  what to focus on, what to verify by running — and (2)
  its own findings, most serious first. Review-only: the
  prompt tells it not to change code. A stale local branch
  of the same name is fast-forwarded to the fetched head;
  a diverged one (probably mine, not theirs) is left alone
  with a warning. Re-running on an existing worktree just
  opens it. Unrelated to `rt`/`rd`/`rp` below, which park
  *my* worktrees in review sections.
- `wt rt` / `wt rd` / `wt rp` — move the current worktree's
  board entry into `# TEAM REVIEW` (`rt`), `# READY TO
  DEPLOY` (`rd`) or `# PROD REVIEW` (`rp`) (reusing a freed
  slot there, else a new line; creates the heading if
  missing), so `wt :` shows it as `TEAM REVIEW: branch`.
  Checkout, branch and tmux session stay. The branch's Linear
  ticket, if any, moves to Team review / Ready to deploy /
  Needs live verification (`lin state`; needs
  `$LINEAR_API_KEY` from polar `secrets/common`; a Linear
  failure never stops `wt`).
- `wt rb [<worktree>|:]` — current worktree is blocked by
  another (branch or dir; none/`:` = fzf): moves it to
  `# BLOCKED` and records it in `<repo>.blocked`. When the
  blocker is removed (`wt rm`/`clean`), it moves back to
  `# IN PROGRESS` and gets an inbox notification (on its
  `cli` pane, else its path, so `M-i` lands there). `wt :` preview shows `blocked by`. Linear:
  ticket → Blocked plus a blocked-by relation when the
  blocker has a ticket; back to In Progress on unblock.
- `wt ip` — move the current worktree back to `# IN
  PROGRESS`, ticket → In Progress (clears a block;
  `rt`/`rd`/`rp` clear it too).
- `wt done [:|<name>]` — `wt rm` that first moves the
  ticket to Done. No arg = the current worktree.
- `wt id` — print the current worktree's slug (= its tmux
  session name) and copy it, to point other agents at it.
- `wt pin [N]` / `wt unpin` — put the current worktree on
  Alt-N (`N` 1–9, 0 = Alt-0; default the first empty key) /
  take it off. Just edits the ts profile (`tsp pin|unpin`)
  as `<repo>:<slug>`; Alt-N attaches the existing session,
  no rebuild. `wt rm` unpins too.
- `wt clean [-f]` — remove every worktree (incl. orphans)
  whose PR is merged (via `gh`), confirming each; `-f` skips
  prompts
- `wt resume <slug>`/`:` — re-materialise a removed
  worktree at the same path and run `claude --continue` in
  its new session's `cli` (context is keyed by path). `:`
  opens the registry graveyard in fzf.
- `wt forget <slug>` — the only true destroy: drop branch
  + `refs/wt/<slug>` so it leaves the resurrectable set.
  Claude context dir left intact.
- `wt dedup` — reinstall across worktrees so Yarn relinks
  node_modules into the hardlinks-global store (run once
  after enabling `nmMode`)
- `wt move [branch]` — stash, create worktree, pop
- `wt e [repo]` — edit worktree order file. In that buffer
  `<CR>` on an entry runs `wt open` for it (opens/attaches its
  session) and quits vim,
  so the pane closes and you land in the worktree. Bound only
  for the worktrees file (ts-*/branch_speeddial keep `<CR>`).
- `wt open <branch>` — open/attach a board entry's session by
  name, no fzf (what the `wt e` `<CR>` mapping calls).

Sessions are always named by worktree slug (the main
checkout by repo name).

Order files at `$LOCAL_CONFIG/worktrees/<repo>` are the
board: sections under `# Foo`/`Foo:` headings. `add`/`fix`/
`feat` append to `# IN PROGRESS` (reusing a freed slot
there, else a new line at the section's end). Removing/
moving an entry (`rm`, `rt`/`rd`/`rp`) deletes its row. No
archiving — removing a worktree drops it from the board into
the registry, where `wt resume` brings it back.

Alt-N speed-dial is separate: line N of the current ts
profile (`tsp`, `$LOCAL_CONFIG/ts-profiles/…`; Alt-0 = line
10). A line is a zoxide name (`notes`, `dotfiles`, `ice-floe`
= main checkout) or `<repo>:<slug>` for a worktree. Blank
lines are empty keys, so numbers stay put. Pin with `wt pin`,
edit with `M-t` (`tsp e`).

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

Where work *runs* is tmux, not `git worktree list`. A
session can edit in one worktree and run its stack or agent
from another. For "where is X happening" / "what's spread
around", start from `tmux list-panes -a -F '#S:#I.#P
#{pane_current_command} #{pane_current_path}'` and map each
session → worktree(s) → agent (`ListAgents`).

## Notifications

A persistent inbox, keyed per tmux **pane**, so
notifications don't flash and vanish. Every notifier funnels
through `bin/notify` (Claude's hook via `claude-notify`,
`git-w8`, `bw8`, …), so `notify` is the one chokepoint:
alongside the macOS toast + sound + tmux bell it appends a
row to `$LOCAL_CONFIG/notifications`
(`epoch ctx title message path pane mode`, tab-separated):
the calling pane's id, its `#S:#W.#P` for display, and its
`pane_current_path` as a stable fallback.

- Two clear modes. Claude rows are `sticky`
  (`NOTIFY_MODE=sticky`): visiting doesn't clear them; my
  reply does (`UserPromptSubmit` hook), as does an approved
  tool running (`PostToolUse`, covers permission prompts).
  Everything else clears on **arrival** at the pane: the
  focus/nav hooks (`pane-focus-in`, `client-session-changed`,
  `after-select-window`) run `notif arrive "#{pane_id}"`.
- `M-i` / `notif next <pane>` — jump to the pending pane
  queued after the current one (oldest if here isn't
  pending), so repeated `M-i` rotates through them.
- `M-u` / `notif later <pane>` — snooze: move this pane to
  the back of the queue as sticky (adds a row if none was
  pending). For "come back to this".
- `M-o` / `notif` — fzf picker: pending panes (`●`, latest
  message + `×N`, newest first), then the last 10 cleared
  ones (`·`) from `notifications.recent`, so "where was I"
  is one pick away. `<Enter>` jumps to the exact pane;
  `ctrl-x` dismisses a pending one.
- Jumps go by pane id, then `session:window` (exact name),
  then recreate the session at the stored path (its worktree
  root). A removed worktree comes back first via `wt resume`
  (Claude continues in `cli`); a place with nothing to
  resume is cleared (`M-i` skips to the next).
- A counter badge (`#(notif count)` → green `(N)`, distinct
  pending panes) sits in `status-right` before the date.
- `M-y` / `notif seen <pane>` — mark this pane done: drop
  its rows (also what the reply hooks run). `notif seen-path
  <dir>` drops every row at or under a dir; `wt rm`/`done`/
  `clean`/`rb`/`rt`/`rd`/`rp` run it for the worktree (not
  `ip`: that's picking work back up). `notif clear` —
  empty the inbox.

`bin/notify` only appends (atomic single-line `>>`, safe
across concurrent Claude sessions); the dedup/count happens
at view time in `bin/notif`.

## Dev stack

Off by default; many sessions share the RAM. Load the
`dev-stack` skill before `dev up`, stop what you started,
never stop what you didn't.

## Git

Use `g s <branch>` to switch branches (not raw
`git switch`). The `git-s` wrapper refreshes the
tmux status bar after switching.

## Branch code isn't released code

Only what's in the base branch exists for users. The
rest of the branch is our draft, and it squash-merges
into base as one change.

So before treating something as existing behaviour or
as a source, check whether it's in base (`git log
origin/<base>..HEAD`). If it isn't:

- It's our work, not a fact. Don't quote it back as
  evidence, and don't defend it as "what the code
  does".
- Nobody depends on it yet. Change it in place. No
  compat layers, fallbacks, deprecated aliases or
  "in case someone already uses it" wrappers for
  shapes that only ever lived on this branch.

Still keep what earns its place in the final change,
like its tests.
