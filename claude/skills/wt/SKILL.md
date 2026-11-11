---
name: wt
description: "How my worktrees, board, notification inbox and Claude logins work: `wt` (add/fix/feat/review/rm/done/cancel/rt/rd/rp/ra/rb/fx/sz/w8/ip/merged/night/resume/clean/pin), the board order files, `wt-sync` and `wt-tell` tells, `notif`/`notify` and the M-i/M-k/M-u/M-o/M-y keys, `cswap` accounts. MUST load before running any `wt`, `notif` or `cswap` command, before answering where work is happening or what is on the board, before listing artifacts or when one reads \"not found\" or \"no access\" (a login swap), and before changing those scripts."
---

# wt, notifications, accounts

Moved out of `~/CLAUDE.md` on 2026-11-03: it re-loaded on every turn
of every session (about 4.4k tokens), while only turns touching
worktrees, the inbox or logins need it.

### Worktree Workflow

Worktrees at `${repo}/.worktrees/${branch}`. Managed via `wt`:
- `wt .`/`rm`/`remove` — remove the checkout AND delete the
  branch, but pin `refs/wt/<slug>` + log to the registry
  first, so it's fully reversible via resume. Reclaims GBs.
  `.` = current, `:` = fzf pick, or `<name>` — a branch
  or worktree dir (slug), resolved via `git worktree
  list`; no match = error. Prints what it's removing;
  the delete itself runs in the background. Then runs the
  repo's trusted `.jrb/wt-hook rm <slug>` (e.g. releasing
  the worktree's ports); `forget` runs it with `forget`.
  `.` in a dir already removed (its session lived on and
  Claude recreated `.claude/`) says so and drops dir +
  session; more than `.claude/` there, it lists and keeps it.
- `wt :` — fzf pick worktree to switch to. Lists from disk
  (`git worktree list`), so it always reflects reality;
  preview (`wt-preview`) shows branch, last commit, PR state,
  and the first prompt of the worktree's last AI session.
  Worktrees under a heading (a `# Foo` or `Foo:` line in the
  order file) show as `HEADING: branch`, on-disk worktrees
  not on the board as `⊘ branch`. Selecting one opens its
  session (named by slug, like every entry point); picking
  an orphan also offers to adopt it onto the board.
  `WT_GROUP` (`:`-separated `[label=]path`, set privately)
  makes it list a group of repos together, each row as
  `label: HEADING: branch`, from any repo in the group;
  repos outside it list alone, as before.
- `wt add <branch>` — create worktree + register
- `wt fix <url|text>` / `wt feat <url|text>` — Linear-aware
  add. A Linear issue URL becomes
  `<type>/${WT_INITIALS:-jrb}/<id>-<slug>` (id + slug parsed
  straight from the URL, no token, any team key — `ABC-`,
  `XY-`, …); a Linear project URL becomes
  `<type>/<initials>/<slug>` (the trailing 12-hex slug id
  dropped); free text is slugified to
  `<type>/<initials>/<slug>`. The `fix`/`feat` prefix
  comes from the command name. E.g. `wt fix
  linear.app/x/issue/ABC-123/fix-the-thing-…` →
  branch `fix/jrb/abc-123-fix-the-thing-…`.
  After creating the worktree it opens the tmux session and,
  for a Linear URL, kicks off a Claude session in the third
  window (`cli`) preloaded with a prompt: `fix` →
  "Can you please fix <url>? Please also examine the video
  and the images"; `feat` → "Can you please read <url> and
  relative feature docs? Then please grill me on the
  solution."; both then add the hand-back bar, in two
  phases. Phase 1 (build and align): test on every surface
  the change touches, publish an artifact of how it was
  tested (design, tests, screenshots), open a draft PR, hand
  back with PR, artifact, what could bite us and an "Added
  beyond the ask" list (each as a question); no
  `/iterate-review`, the row stays IN PROGRESS. Phase 2
  (polish for release, the `/rd` skill): `/iterate-review`
  until green, then `wt rd`. Going straight on is the
  implementing agent's call: yes when no design choice I'd
  want to see is open (clear bug, one obvious behaviour,
  mechanical, exact spec), no for new UI or behaviour with
  more than one reasonable design. My word overrides it: my
  words relayed verbatim, the `rd`/`no-rd` Linear label
  (linear-listener tells the agent when `rd` lands), `/rd`
  or `/ship`. A parent brief never decides it. A project
  URL (either command) gets the plain feat prompt, widened
  to the project's overview, documents, milestones and
  issues. Generic (not per-repo) — relies on
  the default run/vim/cli layout worktrees get with no `.tmux`.
  A repo's own kickoff lines go in `.jrb/wt-prompt` (trusted
  via `dev trust`, like `wt-hook`), never in `bin/wt`.
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
  `$LINEAR_API_KEY`, else `~/.config/linear.env`; a Linear
  failure never stops `wt`).
- `wt rb [<worktree>|:]` — current worktree is blocked by another
  (branch or dir; none/`:` = fzf): moves it to `# BLOCKED` and
  records it in `<repo>.blocked`. Waiting on a person is not a
  block: ask them, then `wt w8`. `wt rb "<reason>"` still parses,
  but nothing lifts a free-text block but `wt ip`, so it stalls
  and never comes back on its own: don't use it. When the
  blocker is removed (`wt rm`/`clean`), it moves back to
  `# IN PROGRESS` and gets an inbox notification (on its
  `cli` pane, else its path, so `M-i` lands there). `wt :` preview shows `blocked by`. Linear:
  ticket → Blocked plus a blocked-by relation when the
  blocker has a ticket; back to In Progress on unblock.
- `wt fx ["<what I must do>"]` (`focus`) — my next step needs
  more than a minute of focus (manual setup, a direction check):
  moves the row to `# NEEDS FOCUS`, ticket → Owner review, reason
  in `<repo>.needsfocus` (shown by the `wt :` preview). Quick
  unblocks first: unlike `rd` it keeps the inbox, and `M-i` ranks
  its pings after every other class (an `M-k` focus still wins).
  `ip`/`rt`/`rd`/`rp` move it out.
- Coming back later: waiting on something (CI, a deploy, a
  review, a reply) → `wt w8`; knowing when you want to wake up →
  `wt sz`. Nothing else schedules a wake-up: the `timer-gate` hook
  denies sleep loops, background timers, `at`, cron and launchd.
- `wt sz <when>` (`snooze`) — park the current worktree under
  `# SNOOZED` until a date or time: `monday`, `tomorrow`,
  `+3 days`, `2026-10-19`, `+3 hours`, `15:00` (parsed by
  `gdate -d`, must be in the future), recorded in
  `<repo>.snoozed` as slug/branch/date[Ttime]/section/start/main
  checkout. `wt-sync` runs `wt wake` every minute in each repo of
  its list and each repo with a snooze (so a reboot doesn't lose
  one; a date alone is due at 08:00), and so does every `wt` run:
  what's due goes back to the
  section it was snoozed from (else `# IN PROGRESS`), and its agent
  is told when it was snoozed and woke, and to double-check, same
  path as unblocking. Unlike `rb`, Linear is left
  alone: a snooze is when I plan to look again, not a state the
  team shares. Snoozing clears its inbox, and `notify` stays
  silent for a snoozed worktree (so its Claude finishing
  doesn't put it back) until it wakes. A block survives the
  snooze; the blocker going away wakes it early (unblock).
  `rt`/`rd`/`rp`/`ip` clear a snooze.
- `wt night [HH:MM]` (`wt-night`) — leaving for the night
  (default until 07:30): `caffeinate` until then, and each idle
  agent of a `# IN PROGRESS` worktree is told to work alone to
  the hand-back bar, taking its own recommended answers (phase
  1 only, unless it has `/rd` or the `rd` label). Skipped:
  open PRs that are green and wait on me, worktrees with no
  session, busy agents. A finished one replies so and stops: no
  invented work. Told in the background, paced: at most 3
  busy at once, none while free memory < 8 GB or pressure is
  up (`wt-night.log`). Agents queue follow-up tickets with
  `wt night queue <url>`, started (`wt feat`) under the same
  limits. 15 min before, agents told that night whose PR
  fails CI are told to fix it. Once per
  worktree per night; `WT_NIGHT_DRY=1` lists who'd be told.
- `wt ip` — move the current worktree back to `# IN
  PROGRESS`, ticket → In Progress (clears a block;
  `rt`/`rd`/`rp` clear it too).
- `wt w8 <duration|time> "<what>"` (`wait`) — the worktree
  waits on an event (never on me: it hides my question
  from `wt-cold`, so `wt w8` refuses one) until a deadline (`45m`, `2h`, `15:00`),
  in `<repo>.waiting`. Agents: before starting any wait or poll
  (deploy, CI, review, a colleague's answer, logs, a live effect
  to check such as the next scheduled run), run `wt w8 <your
  estimate> "<what>"`, never ask me whether to wait. When the
  event arrives, `wt w8 done` (ends the wait, board untouched).
  Within a minute of the deadline, at any hour and after a reboot,
  `wt-sync` tells its agent what it waited on, when it expected
  it, and to check now (`wt-tell`, retried via `wt-unblocked`), in
  any repo: the row carries its main checkout. Any overdue w8 not
  yet told is told, however old; once each. Until that tell
  lands I get "overdue: <what>: investigate" (`wt-cold --overdue`,
  that row only, its own row even over an unread one; repos in
  `wt-sync`'s list); a landed tell drops it, since the agent pings
  me if it needs me.
  Cleared by `w8 done`/`ip`/`rt`/`rd`/`rp`/`ra`/`sz`/`done`/`rm`
  and by its deadline tell. Any other tell (merged, deploy stage,
  unblock, …) leaves it open: only the agent knows if that was
  the event, so the tell ends with what it waits on, until when
  (or that it is overdue), and to `wt w8 done` if so.
- `wt merged` — its PR merged: parks the worktree in `# PROD
  REVIEW` (ticket → Needs live verification) when the repo's
  hook says it's already shipping to production (`jrb-hook
  shipping`), else `# READY TO DEPLOY` (unless
  already in one of those or `# TO ANNOUNCE`; when shipping it also
  sets `wt w8 90m` on the deploy unless a wait is set, since parking
  and the merge tell end waits), then unblocks the
  worktrees `wt rb`'d on it; an idle one's agent is told to rebase
  onto dev and carry on. I don't run it: when a PR merges, its
  agent is told (`pr-merged-tell`, from `claude-notify` or the
  `wt-sync` launchd job every minute) to check where it's
  headed (`jrb-hook merged-hint`) and run it; a session that
  isn't running is started with its agent first.
  Where the merge is the release (no deploy step, e.g. a tooling
  repo with no hook) READY TO DEPLOY is wrong: `wt rp`, `wt w8`
  until its effect should show, check it, then `wt done`.
  No inbox ping for it. A PR that needs no deploy (`jrb-hook
  nodeploy`) gets one tell at merge to check it where it runs
  and close the ticket. Deploy and ship-queue tells (on a
  stage, rejected, failed) come from the repo's `.jrb/wt-hook
  sync`, which `wt-sync` runs per repo. All go
  through `wt-tell`: idle Claude gets the prompt, a worktree
  with no session gets me a `check` ping.
- Telling another agent yourself (`wt-tell <worktree path> <key>
  <ping> <prompt>`, path not slug): send the goal and why, in a
  few sentences, and let the agent pick the how. No file lists,
  steps or "every X" scope: it follows them literally, and I
  often mean "where it makes sense". One tell per key and
  worktree; a correction is a new key. Exit 1 with no output means
  its Claude is busy and nothing was delivered: retry when idle,
  don't assume it landed.
- `run-slot` — every agent start (tells, revives, detached
  `wt feat|fix`, swarm `launch`) waits there until the Mac has
  room (under the cap of working chats, free memory above the
  floor after the start, pressure normal; revives, then tells,
  then starts). A revive of a chat that was mid-turn goes past
  the cap while memory is calm. A detached `wt feat|fix` waits
  in its own `cli` pane (`run-slot wait`), which shows its
  place in the queue and why. `wt-sync` closes a Claude whose turn ended an hour
  ago and whose process started over an hour ago (a revive
  counts from its restart), not asking me, unfocused, nothing
  running, no tell on its way, no open `wt w8`, not named in
  `$LOCAL_CONFIG/run-slots/keep`: sessions I drive from my phone
  through Remote Control, which dies with the process. The next
  tell, a focus on its pane or `run-slot revive` resumes it. A
  tell that revives hands itself to `run-slot pend`: the pump
  types it once Claude is ready (up to 3 days), and the chat
  stays open until then. A main checkout's session holds many
  chats, so a chat there is found by sid only (`WT_TELL_SID`,
  inbox jumps), never `--continue`: focusing its pane resumes one
  only while it has an inbox row, and a tell with no sid becomes
  a ping. `run-slot ls` shows room, queue, pending tells and
  closed sessions.
- `wt done [:|<name>]` / `wt cancel [:|<name>]` — `wt rm`
  that first moves the ticket to Done / Canceled (refuses
  to remove if Linear fails); `cancel` also closes my open
  PRs from the branch (`gh pr reopen` undoes). No arg = the
  current worktree.
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
  still needs checking in prod, so `wt done` removes them
  (or `wt-cold`, once its ticket is Done or Canceled).
  First sweeps subagent worktrees
  (`.claude/worktrees/agent-*`, invisible to `wt`) untouched
  for `WT_AGENT_TTL` hours (24): pinned to `refs/wt/<id>`,
  then removed. So when an isolated agent returns,
  cherry-pick what you keep into your branch right away —
  its worktree is scratch.
- `wt resume <slug>`/`:` — re-materialise a removed
  worktree at the same path and run `claude --continue` in
  its new session's `cli` (context is keyed by path), its
  row back in the section it left (a `done`/`cancel`ed one
  stays off the board: `wt ip` to work on it). `:` opens
  the registry graveyard in fzf.
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

One tmux server (`default`) holds every session: M-i, switches
and pane ids all assume it (a split onto agents-N servers broke
them, RAS-37). The `tmux` shim only guards: it refuses
`kill-server` on the real `default` (`TMUX_KILL_SERVER=1` to mean
it) and an empty or missing `TMUX_TMPDIR`, the test cleanup that
killed every agent; and a `TMUX_TMPDIR` other than /tmp beats the
pane's `$TMUX`, so a test's tmux reaches its own server.

The server's sockets live in `~/.local/state/tmux`, not /tmp:
tmux falls back to /tmp for a `TMUX_TMPDIR` it can't use, so
tmux-watch keeps a plain file at /tmp/tmux-UID and that fallback
errors instead of reaching every agent (RAS-41). A server still in
/tmp is adopted; the next start moves it.

`tmux-watch` (launchd) keeps the server up: on a death it logs
the cause (`tmux-watch.log`: signal, exit status, the shim's
kill-server row naming its caller, crash report), starts the
server again and runs `tmux-revive` at once. tmux-revive
snapshots every Claude pane every 20 s (session,
window, cwd, sid, mid-turn or not) and rebuilds the dead server's
sessions under their old names: mid-turn chats first, each
resumed (`claude --resume <sid>`) past the cap and told at its
empty prompt to check git status and carry on; then idle ones
it still needs (a recent turn, asking me, a tell, `wt w8` or
timer due) resumed as room allows, the rest parked as closed
rows that a focus or tell resumes. One ping sums up revived,
told, parked and failed, with the cause (`tmux-revive.log`).
Panes it didn't build are never touched. To keep a deliberate
`kill-server` dead, run `tmux-revive forget` right after it.

Order files at `$LOCAL_CONFIG/worktrees/<repo>` are the
board: sections under `# Foo`/`Foo:` headings. `add`/`fix`/
`feat` append to `# IN PROGRESS` (reusing a freed slot
there, else a new line at the section's end). Removing/
moving an entry (`rm`, `rt`/`rd`/`rp`) deletes its row. No
archiving — removing a worktree drops it from the board into
the registry, where `wt resume` brings it back.

`wt-badge` puts the current worktree's section in tmux
`status-right`, before the inbox count, as coloured text
(`in progress`, `team review`, `blocked`, `off board`, …); an
active `wt w8` shows instead as `w8 15:40 <what…>` (red
`overdue` past the deadline). A worktree on a priority gets a red
`P0 #N` before it.

Priorities (P0s): `$LOCAL_CONFIG/priorities`, one outcome per line
in rank order, indented sources (`> Who date link "quote"`) and steps
(`- [ ] ABC-123 …`; first unchecked = current). `prio` lists, `M-,` /
`prio e` edits in a popup (moving or deleting a line is the re-rank;
a hand-deleted outcome or step is never re-added by capture, and an
outcome moved up by hand stays above `prio add --top`). Capture:
`prio add [--top] [--by] [--date] [--link] [--quote] "<outcome>"
[step…]` (exit 3: removed by hand). A worktree is on priority N when
its branch names the ticket of an unchecked step of N. Every minute
`prio sync` (from `wt-sync`) moves such board rows into a `# P0`
section at the top (back to their old section, kept in
`<repo>.p0`, when the priority goes; PROD REVIEW, TO ANNOUNCE,
BLOCKED, NEEDS FOCUS and SNOOZED rows stay put), and gives each
priority whose current step no worktree carries a silent `step`
inbox row; jumping to it opens the popup. `wt feat|fix` warns (never
blocks) when the new branch is on no priority while a P0 worktree is
stalled or has no agent. `prio brief` is the morning text; the side
files and the rest are in `bin/prio`'s header.

Alt-N speed-dial is separate: line N of the current ts
profile (`tsp`, `$LOCAL_CONFIG/ts-profiles/…`; Alt-0 = line
10). A line is a zoxide name (`notes`, `dotfiles`, a repo
= main checkout) or `<repo>:<slug>` for a worktree. Blank
lines are empty keys, so numbers stay put. Pin with `wt pin`,
edit with `M-t` (`tsp e`).

Removed worktrees append to `<repo>.registry` (append-only,
never blanked): `slug<TAB>branch<TAB>sha<TAB>date<TAB>left`
(section it left, or Done/Canceled). The
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

### Notifications

A persistent inbox, keyed per tmux **pane**, so
notifications don't flash and vanish. Every notifier funnels
through `bin/notify` (Claude's hook via `claude-notify`,
`git-w8`, `bw8`, …), so `notify` is the one chokepoint:
alongside the macOS toast + sound + tmux bell it appends a
row to `$LOCAL_CONFIG/notifications`
(`epoch ctx title message path pane mode class sid`,
tab-separated): the calling pane's id, its `#S:#W.#P` for
display, its `pane_current_path` as a stable fallback, and for
Claude its session id (sid). A chat is its sid, not its pane:
panes die and the main checkout's session holds many chats, so
anything that must find a chat again (inbox jumps, `chats`
M-/, Slack watches) keeps the sid and asks `claude-pane`.

- Two clear modes. Claude rows are `sticky`
  (`NOTIFY_MODE=sticky`): visiting doesn't clear them; my
  reply does (`UserPromptSubmit` hook), as does an approved
  tool running (`PostToolUse`, covers permission prompts).
  Everything else clears on **arrival** at the pane: the
  focus/nav hooks (`pane-focus-in`, `client-session-changed`,
  `after-select-window`) run `notif arrive "#{pane_id}"`.
- `M-i` (left hand: `M-e`) / `notif next <pane>` — jump to the pending pane
  queued after the current one (oldest if here isn't
  pending), so repeated `M-i` rotates through them. Pings of
  worktrees on priority 1 come first, then 2, …, then the rest;
  class orders within each.
- `M-k` / `notif focus <pane>` — toggle focus on this pane's
  worktree (main checkout: its Claude chat, by sid): when it pings, it ranks above every class and `M-i`
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
- `notif depth` — the inbox as inventory: pending now with ages,
  per workday pings in / cleared / pending at end of day / peak /
  median wait (cleared rows kept in `notifications.log`), then
  `wt-cold --brief`: work items per state and the STALLED list.
- `wt-cold` — stalled work reaches me. The design follows
  Goldratt's The Goal: my attention is the constraint, so it must
  never idle while work waits in front of it. Every item is active,
  waiting, snoozed or stalled. Stalled pings until touched, so an
  empty inbox means nothing is waiting on me. Don't add rules that
  let work go quiet without a state. States, checked in order:
  REMOVED (a PROD REVIEW row whose ticket is Done or Canceled, or,
  with no ticket, whose PR closed and worktree is gone: `--ping`
  takes it off the board with `wt retire`, like `wt done` minus
  Linear, keeping a checkout with unpushed work on disk; logged to
  `wt-cold-retired.log`, never pinged), SNOOZED (`wt sz` to a future date; the only parking), WAITING (a
  `wt w8` before its deadline, beating everything else; else a
  background agent/shell under 60 min), ACTIVE (agent mid-turn; 60
  min with no pane change or commit = STALLED "spinning?"), STALLED
  (the rest, incl. waiting on me). BLOCKED inherits its blocker's
  state; blocked on a ticket = WAITING while it's started and
  touched within a workday (Linear), else STALLED; a free-text block
  is STALLED until it's a ticket or snoozed. Blocked on a stalled
  worktree, it has no row of its own: the blocker's row says "+N
  blocked on this". Each other STALLED item gets
  one silent `stalled` row (ranked below merge/blocked, above fyi)
  saying the next move; a pending row of its own makes it "waiting
  on you: …" instead (for a bare "done": the agent's last question,
  else section and PR state; an overdue w8 keeps its own row).
  Re-pings `WT_STALL_MIN` (30) weekday-minutes
  after a clear; auto-clears on the next run once it isn't stalled
  (rows carry a ref, `notif seen-ref`, so a jump that re-keyed one
  onto a pane doesn't strand it). Batched rows:
  stale board rows, open PRs off the board, worktrees off the
  board. `wt-sync` runs it every 10 min, weekdays 08–19; bare
  `wt-cold` is the dry run. Each pinging run appends its counts to
  `stalled.log` (epoch, stalled, waiting, active, snoozed, inbox
  pending), which the my-impact daily review reads.
- `btabs` — browser tabs as inventory: count, duplicates, by host.
  `btabs expire` (`wt-sync`, every minute, before anything that can
  hang) closes any tab left unfocused `BTABS_IDLE_MIN` (240) awake
  minutes, shell-opened and sign-in leftovers after 5, extra copies of
  a page at once; never a window's active tab or a call. `-n` lists.
  `btabs tidy` adds tabs of merged/closed PRs (once a weekday from
  08:00). Logged; `btabs reopen` undoes. Count every 5 min in
  `tabs.log`.
- `M-$` — popup of sessions ranked by token burn (`tok-top
  --fzf`); Enter jumps to the session.
- `M-o` / `notif` — fzf picker: pending panes (`●`, latest
  message + `×N`, newest first), then the last 10 cleared
  ones (`·`) from `notifications.recent`, so "where was I"
  is one pick away. `<Enter>` jumps to the exact pane;
  `ctrl-x` dismisses a pending one.
- Jumps go by sid first: the chat's live pane, else
  `claude --resume` in a new window of its checkout's session
  (`claude-pane open`). Then by pane id, then `session:window`
  (exact name),
  then recreate the session at the stored path (its worktree
  root). A removed worktree comes back first via `wt resume`
  (Claude continues in `cli`); a place with nothing to
  resume is cleared with a "Cleared <ctx>: gone" message. A place
  that exists but won't take the switch keeps its rows: `M-i`
  moves on and names it ("Could not switch to …").
- A counter badge (`#(notif count)` → green `(N)`, distinct
  pending panes) sits in `status-right` before the date.
- `M-y` / `notif seen <pane>` — mark this pane done: drop
  its rows (also what the reply hooks run). `notif seen-path
  <dir>` drops every row at or under a dir; `wt rm`/`done`/
  `clean`/`rb`/`rt`/`rd`/`rp` run it for the worktree (not
  `ip`: that's picking work back up). `notif seen <key>
  stalled` drops only that key's `stalled` rows. `notif clear` —
  empty the inbox.

`bin/notify` only appends (atomic single-line `>>`, safe
across concurrent Claude sessions); the dedup/count happens
at view time in `bin/notif`.

### Claude accounts

Logins are managed by `cswap` (claude-swap, pipx); all accounts
share `~/.claude`. launchd `com.jrasmusbm.cswap-auto` runs
`cswap-auto` every minute: `cswap auto --once` (switch at 98%
of the 5h/7d limit, `CSWAP_AUTO_THRESHOLD`), then
`/remote-control` into every idle Claude pane whose Remote Control dropped from the login change,
so the phone sees it under the new account (log:
`$LOCAL_CONFIG/cswap-auto.log`; `cswap-auto -n` lists targets). `cswap list` shows usage; add an
account with `/login` then `cswap add --alias <name>`.
An artifact published before a swap reads "not found" after it
unless I shared it with my other login. When the work needs that
artifact (to update it, or a link I'll open), don't report that or ask
me to share: republish it under the active login (`/repa`) and from
then on update that copy, never the one you can't reach. A "Stopped
watching Artifact … (artifact not found)" notice is not that need:
every swap ends each old watch, and the notice wakes the idle session
for a full context re-read. End the turn at once with no tool call and
no text, and don't republish or watch it again: each extra call
re-reads the whole context again.
A session sees only its active login's artifacts; the
`artifact-ledger.sh` hook logs every publish with its login, and
`artifacts` (this dir; `all`; or a query) lists them across logins,
newest copy `current`, older ones `stale`. Borrowed logins (someone
else's, `~/.config/borrowed-logins`, overlay) never publish:
`artifact-local.sh` refuses, opens the file locally and logs
it as a `file://` row; report that path and SendUserFile it. They
never write to Slack either (`slack-borrowed.sh` denies the
connector's send/react/canvas tools, which act as that person): hand
`slack-post` (overlay) posts as me instead, else I paste. Nor do they
get Remote Control: each connected session pushes to the owner's
phone. The `cswap` shim switches to one only after `claude-rc-off`
has it off in every pane (waits for busy ones, holds cswap-auto),
and refuses `run`/`enable` on it. Listing artifacts =
Artifact `list` plus `artifacts`. Every artifact link you report
names its login (`artifacts` shows it) unless it's shared, and
when copies exist on both logins, say which is current.
