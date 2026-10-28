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
Don't ask "Want me to do X?" — just do it. Includes UI and visual
changes (build it and show me, don't post a mockup and wait),
committing what you fixed once verified (only your hunks), and my
PRs: push to the branch and keep the title/body in sync without
asking, then report the head sha (watch CI only in `/iterate-review`
or when asked; merge or deploy only on my word, through the conveyor
where a repo has one, then end the turn: `wt-sync` tells you what
happens next), and "is it released/deployed?":
confirm it is live, then run read-only checks that it behaves as
intended (logs, replica, live bundle). Long pipelines, polls and
browser loops run in a background agent; the main thread stays free
to talk. A branch I cite as prior work is the starting point: `git
show` it, port and extend, and say what came from it.

Never end a turn with a list of what's left that you could do
yourself ("still needs doing", "I'd now…", "I haven't verified X"):
do it, then report. When unsure, take the option that's cheap to
undo, do the work, and ask only about that cheap change. Example:
fix in this PR whatever would break prod. For a fix that might
belong in a follow-up, build it as a follow-up PR and ask whether
to pull it back in, so my answer is a quick git move, not a build.

Replace, don't accrete. Rewrite what's there, don't append beside it.
Adding lines? Name what they replace. A narrow ask gets a narrow
diff: "add logs" = log lines only, no refactor feeding them; "X
overstates" = change X, no added caveats, owners or follow-ups.

Shared infra: a question ("you didn't clobber staging?") is
read-only, report and ask before any write. Follow a rollback plan
you announced, or say "I said X, doing Y because Z" first; never
delete its artifact.

## Questions

Questions stall work. Default: don't ask; act on the
cheap-to-undo option and say what you assumed. When a
question is unavoidable, ask it in plain text, once, at the
end, with your recommended answer. No AskUserQuestion
dialogs unless I ask to pick between options.

My questions aren't instructions: "why X?", "could we Y?", "will
that work if Z?" get an answer with the trade-off, then stop. Build
only on "do it"; proactive means doing agreed work unasked.

## Communication

Extremely concise. Sacrifice grammar for concision.
When explaining: provide context + doc links.
When investigating: explain approach.
Voice typing: interpret phonetic errors from context
(cloud MD → CLAUDE.md, sim link → symlink, get hub → GitHub).
Link to open → bare URL on its own line, not only [text](url).
Drafts I'll send: literal plain phrasing, no idioms; links
`[text](url)`, never `<url|text>`; the whole draft each revision.
Slack posts: edit here, send only on my "send", never save drafts.
Exception: a `claim-work` claim reply is sent unasked.
Screen recordings (.mov/.mp4) I share: extract frames with
`ffmpeg -i <file> -vf fps=2 <scratchpad>/f%03d.png` and Read them.

## Plans

Extremely concise. End with unresolved questions if any.
Before asking approval: load the skills, read the files to change,
and turn every risk you can check now into a fact. A stakeholder's
spec is the source of truth; an unspec'd case takes the closest
spec'd state. Multi-piece work: orthogonal agent-ready briefs
(goal, deps, settled context, files to read, skills, grill-on,
acceptance, boundaries), a shared settled section, a task graph.

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

In my tooling repos (dotfiles, ~/projects/polar incl. jrb), commit
each change as soon as it works, staging explicit paths (never
`commit -a`: secrets live nearby). I edit none of it by hand, so an
uncommitted change you find is another agent's: read it, commit it
if it holds up (secrets go to an ignored file instead), and never
call it mine.

## Platform Quirks

macOS ships BSD awk and sed. Use `gawk` / `gsed` for GNU features
(`sed -i` without a suffix arg fails on BSD sed).

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
  solution."; both then add the hand-back bar: test on
  every surface the change touches, publish an artifact of
  how it was tested, run `/iterate-review` until green, hand
  back with PR, artifact and what could bite us. A project
  URL (either command) gets the plain feat prompt, widened
  to the project's overview, documents, milestones and
  issues. Generic (not per-repo) — relies on
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
- `wt rt` / `wt rd` / `wt rp` / `wt ra` — move the current
  worktree's board entry into `# TEAM REVIEW` (`rt`), `# READY
  TO DEPLOY` (`rd`), `# PROD REVIEW` (`rp`) or `# TO
  ANNOUNCE` (`ra`: verified live, release post not yet out)
  (reusing a freed
  slot there, else a new line; creates the heading if
  missing), so `wt :` shows it as `TEAM REVIEW: branch`.
  Checkout, branch and tmux session stay. The branch's Linear
  ticket, if any, moves to Team review / Ready to deploy /
  Needs live verification / Needs announcement (`lin state`; needs
  `$LINEAR_API_KEY` from polar `secrets/common`; a Linear
  failure never stops `wt`).
- `wt rb [<worktree>|:|"<reason>"]` — current worktree is blocked
  by another (branch or dir; none/`:` = fzf), or by something
  that isn't a worktree, given as a reason (`wt rb "design review
  with Marina"`, `wt rb "risks to settle with Pascal"`): moves it
  to `# BLOCKED` and records it in `<repo>.blocked` (a reason in
  column 4, shown by the `wt :` preview; only `wt ip` lifts it).
  A PR that can't merge yet goes here with its reason, so nothing
  treats it as abandoned or picks it up. When the
  blocker is removed (`wt rm`/`clean`), it moves back to
  `# IN PROGRESS` and gets an inbox notification (on its
  `cli` pane, else its path, so `M-i` lands there). `wt :` preview shows `blocked by`. Linear:
  ticket → Blocked plus a blocked-by relation when the
  blocker has a ticket; back to In Progress on unblock.
- `wt sz <when>` (`snooze`) — park the current worktree under
  `# SNOOZED` until a date or time: `monday`, `tomorrow`,
  `+3 days`, `2026-10-19`, `+3 hours`, `15:00` (parsed by
  `gdate -d`, must be in the future), recorded in
  `<repo>.snoozed` as slug/branch/date[Ttime]/section/start. A time
  also starts a detached timer that runs `wt wake` then.
  Every `wt` run wakes whatever is due — back to the section it
  was snoozed from (else `# IN PROGRESS`), and its agent is told
  when it was snoozed and woke, and to double-check, same path as unblocking — so the board
  corrects itself the next time `wt` is used on or after the
  date; `wt wake` forces the check. Unlike `rb`, Linear is left
  alone: a snooze is when I plan to look again, not a state the
  team shares. Snoozing clears its inbox, and `notify` stays
  silent for a snoozed worktree (so its Claude finishing
  doesn't put it back) until it wakes. A block survives the
  snooze; the blocker going away wakes it early (unblock).
  `rt`/`rd`/`rp`/`ip` clear a snooze.
- `wt night [HH:MM]` (`wt-night`) — leaving for the night
  (default until 07:30): `caffeinate` until then, and each idle
  agent of a `# IN PROGRESS` worktree is told to work alone to
  the hand-back bar, taking its own recommended answers. Skipped:
  open PRs that are green and wait on me, worktrees with no
  session, busy agents. A finished one replies so and stops: no
  invented work. Told in the background, paced: at most 3
  busy at once, none while free memory < 8 GB or pressure is
  up (`wt-night.log`). Agents queue follow-up tickets with
  `wt night queue <url>`, started (`wt feat`) under the same
  limits. 15 min before, agents told that night whose PR
  conflicts with dev or fails CI are told to fix it. Once per
  worktree per night; `WT_NIGHT_DRY=1` lists who'd be told.
- `wt ip` — move the current worktree back to `# IN
  PROGRESS`, ticket → In Progress (clears a block;
  `rt`/`rd`/`rp` clear it too).
- `wt merged` — its PR merged: parks the worktree in `# PROD
  REVIEW` (ticket → Needs live verification) when the conveyor is
  already shipping it to production, else `# READY TO DEPLOY` (unless
  already in one of those or `# TO ANNOUNCE`), then unblocks the
  worktrees `wt rb`'d on it; an idle one's agent is told to rebase
  onto dev and carry on. I don't run it: when a PR merges, its
  agent is told (`pr-merged-tell`, from `claude-notify` or the
  `wt-sync` launchd job every minute) to double-check the conveyor
  and run it; a session that isn't running is started with its
  agent first.
  No inbox ping for it. A conveyor ship that ends rejected or
  failed is told too (polled when the queue's counts move).
  Once every target the PR needs is deployed to a stage after
  it reached that branch (`pr-where --status`, the rule
  `deploy-plan` uses; whoever dispatched the runs), `wt-sync`
  tells the agent once per stage to verify it there; a PR that
  needs no deploy (tests, docs, CI only) gets one tell at merge to
  check it where it runs and close the ticket. Both go
  through `wt-tell`: idle Claude gets the prompt, a worktree
  with no session gets me a `check` ping.
- `wt done [:|<name>]` / `wt cancel [:|<name>]` — `wt rm`
  that first moves the ticket to Done / Canceled (refuses
  to remove if Linear fails). No arg = the current worktree.
  Reversible (`wt resume`), so an agent whose ticket is
  finished runs `wt done` itself and reports it; never
  "Should I run it?", and its stop then sends me no ping
  (`claude-notify`), unless it asks something. Finished = merged,
  verified live, and announced if users or the team see it (a
  release post in #what-did-we-ship / #shipped-fixes, `release`
  skill). Whether it's announced is my call, not the agent's: once
  verified live (or merged, when it needs no deploy), it drafts
  the post, parks the worktree with `wt ra`, and waits. I say
  send (it posts, then `wt done`) or not needed (`wt done`).
- `wt id` — print the current worktree's slug (= its tmux
  session name) and copy it, to point other agents at it.
- `wt pin [N]` / `wt unpin` — put the current worktree on
  Alt-N (`N` 1–9, 0 = Alt-0; default the first empty key) /
  take it off. Just edits the ts profile (`tsp pin|unpin`)
  as `<repo>:<slug>`; Alt-N attaches the existing session,
  no rebuild. `wt rm` unpins too.
- `wt clean [-f]` — remove every worktree (incl. orphans)
  whose PR is merged (via `gh`), confirming each; `-f` skips
  prompts. Keeps `# PROD REVIEW` entries: a merged PR there
  still needs checking in prod, so `wt done` removes them.
  First sweeps subagent worktrees
  (`.claude/worktrees/agent-*`, invisible to `wt`) untouched
  for `WT_AGENT_TTL` hours (24): pinned to `refs/wt/<id>`,
  then removed. So when an isolated agent returns,
  cherry-pick what you keep into your branch right away —
  its worktree is scratch.
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

`wt-badge` puts the current worktree's section in tmux
`status-right`, before the inbox count, as coloured text
(`in progress`, `team review`, `blocked`, `off board`, …).

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
- `M-k` / `notif focus <pane>` — toggle focus on this pane's
  worktree: when it pings, it ranks above every class and `M-i`
  from anywhere goes there first. No ping, no pull: it only calls
  me back when it needs me. For "this one matters most, don't
  lose it behind 30 others".
- `M-u` / `notif later <pane>` — snooze: move this pane to
  the back of the queue as sticky (adds a row if none was
  pending). For "come back to this". If the pane is running
  a command (not a shell, Claude or an interactive app
  like vim/less/lazygit, see `bin/notif`), it instead sets
  `@notif_done` and zsh's `precmd` notifies when that
  command finishes ("done" / "FAILED (exit N)").
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

Type-aware eslint/tsc builds a full TS program (1.5–4 GB) per
run. A `PreToolUse` hook (`heavy-slot hook`) prefixes agents'
`eslint`/`tsc`/`yarn lint*`/`check-ts*` commands with
`heavy-slot take $$`: at most `HEAVY_SLOTS` (2) run at once,
the rest wait ("heavy-slot: … waiting" on stderr). Give such
commands a long `timeout`. `heavy-slot ls` shows holders.
A running dev stack holds one too (`dev:<session>`, 1h,
renewed by any tmux focus on that session; `dev down`
frees it), so a stack left alone gives its slot back.

## Claude accounts

Logins are managed by `cswap` (claude-swap, pipx); all accounts
share `~/.claude`. launchd `com.jrasmusbm.cswap-auto` runs
`cswap-auto` every minute: `cswap auto --once` (switch at 98%
of the 5h/7d limit, `CSWAP_AUTO_THRESHOLD`), then
`/remote-control` into every idle Claude pane whose Remote Control dropped from the login change,
so the phone sees it under the new account (log:
`$LOCAL_CONFIG/cswap-auto.log`; `cswap-auto -n` lists targets). `cswap list` shows usage; add an
account with `/login` then `cswap add --alias <name>`.

## Git

Use `g s <branch>` to switch branches (not raw
`git switch`). The `git-s` wrapper refreshes the
tmux status bar after switching. Rebasing on dev: fetch, reset
local `dev` to `origin/dev` (main checkout: `reset --hard` only if
`status --short` shows no tracked changes, else stop and say so),
then `git rebase dev`.

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
