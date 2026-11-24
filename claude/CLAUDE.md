# Personal Preferences

To empower my agents, I've created /flow, a collection of common situations
agents encounter and how I would reason about them. Refer to it frequently
as the main reference for how I would do things. When you learn something
worth remembering, read flow's learned-something node.

Prefer working with subagents to reduce context and to avoid blocking in the main thread - it should always be responsive.

## Identity

Initials: jrb.
Name: Rasmus Bergström.
Tools: Neovim, Zsh, Alacritty, macOS, Hammerspoon.

## Working Style

Be proactive, not permission-seeking. Make changes first, ask later. Don't ask "Want me to do X?" — just do it.

Replace, don't accrete. Rewrite what's there, don't append beside it.
Adding lines? Name what they replace. A narrow ask gets a narrow
diff: "add logs" = log lines only, no refactor feeding them; "X
overstates" = change X, no added caveats, owners or follow-ups.

## Questions

Avoid AskUserQuestion etc. dialogs, as they block the thread.

## Communication

Be extremely concise when communicating with me. Sacrifice grammar for concision.

Avoid writing [text](url) to me in Claude Code, it gets interpolated and
I cannot follow the link.

Voice typing: interpret phonetic errors from context
(cloud MD → CLAUDE.md, sim link → symlink, get hub → GitHub).

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

macOS ships BSD awk and sed. Use `gawk` / `gsed` for GNU features
(`sed -i` without a suffix arg fails on BSD sed).

## CLI Conventions

- No args = sane default (help or primary action)
- `:` = fuzzy find
- `.` = current context (branch/issue/worktree)
- Explicit arg = use directly

## Worktrees, inbox, accounts

Worktrees live at `${repo}/.worktrees/${branch}`, sessions are named
by worktree slug, and work moves only through `wt` (never raw `git
worktree add`). Load the `wt` skill before any `wt`, `notif` or
`cswap` command, a question about the board, the inbox or where
work runs, listing artifacts or one that reads "not found", and
for starting, parking, splitting or finishing work.

## Dev stack

Off by default; many sessions share the RAM. Load the
`dev-stack` skill before `dev up`, stop what you started,
never stop what you didn't.

Stacks, devtools browsers and type-aware tsc/eslint share one
weighted pool (`pool ls`): hooks queue agents first in first
out, and a queued tsc command waits ("pool: queued …" on
stderr), so give it a long `timeout`. Repos listed in
`~/.config/pool-no-local-tsc` refuse local tsc/check-ts (4-8 GB
each): push to the PR and read CI's typecheck.

## Shared slots

A slot is a lease, not a reservation: hold it only while using
it, and release it on any wait (a person, CI, an agent, another
queue). Prepare before taking one: the code done, the build
green, the checklist written, the person you need at the
keyboard. One heavy job per session, at the smallest scope
that answers the question (changed files first). Where the
repo's CI runs the full checks on a PR, let CI run them.
Never rush or expedite one item past a queue, nor offer to: it
only reorders the same line (Goldratt). A queue that is too slow
is a system fix; a shared blocker (a broken base, a stuck queue):
fix it once and say so, so others don't too.

## Git

Use `g s <branch>` to switch branches - it refreshes the
tmux status bar. Be smart about rebases, avoid issues caused by stale code while
minimizing useless time spent in CI (I.e. continually rebasing when not
actively) preparing to ship.

Rebasing on main is always allowed for own branches: fetch, reset main to origin,
rebase branch on it - then `git push --force-with-lease`. Never force a shared
branch (base branches, someone else's or a branch another PR stacks on).

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
