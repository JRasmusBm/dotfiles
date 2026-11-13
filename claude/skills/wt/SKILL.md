---
name: wt
description: "How my worktrees, board, notification inbox and Claude logins work: `wt` (add/fix/feat/review/rm/done/cancel/rt/rd/rp/ra/rb/fx/sz/w8/ip/merged/night/resume/clean/pin), the board order files, `wt-sync` and `wt-tell` tells, `notif`/`notify` and the M-i/M-k/M-u/M-o/M-y keys, `cswap` accounts. MUST load before running any `wt`, `notif` or `cswap` command, before answering where work is happening or what is on the board, before listing artifacts or when one reads \"not found\" or \"no access\" (a login swap), and before changing those scripts."
---

# wt, notifications, accounts

Usage and mechanics: `wt help`, and each script's header
(`bin/wt`, `wt-cold`, `notif`, `run-slot`, `prio`, `tmux-revive`). This
skill is only what changes your decisions.

## Board and where work runs

The board is `$LOCAL_CONFIG/worktrees/<repo>`: sections under `# Foo`
headings. `wt` commands move rows and the branch's Linear ticket with
them; never edit rows by hand or use raw `git worktree`.
Where work *runs* is tmux, not `git worktree list`: start from
`tmux list-panes -a` and map session (= worktree slug) → worktree →
agent. One tmux server, `default`, holds every session: never
`kill-server` it, and a test's tmux gets its own `TMUX_TMPDIR`.

## Which command

- Start: `wt fix|feat <linear url|text>`, `wt review <pr>` (someone
  else's work: review only, no code changes), `wt add <branch>`.
- Blocked by another ticket's PR: `wt rb <worktree|ticket>`. Never a
  free-text reason: nothing lifts it, so it stalls. Waiting on a person
  isn't a block: ask them, then `wt w8`.
- Waiting on an event (CI, deploy, review, a reply, a scheduled run):
  `wt w8 <estimate> "<what>"` before you start waiting, never on me and
  never ask whether to wait; `wt w8 done` when it arrives. Other tells
  (merged, deploy stage) don't end it: only you know if that was it.
- Know when to look again: `wt sz <when>`. Nothing else schedules a
  wake-up; sleep loops and timers are denied.
- My next step needs real focus (manual setup, a direction check):
  `wt fx "<what I must do>"`.
- Park: `wt rt` team review, `wt rd` ready to deploy, `wt rp` prod
  review, `wt ra` to announce, `wt ip` back in progress.
- PR merged: you get told; run what `jrb-hook merged-hint` says. Where
  the merge is the release (a tooling repo), not READY TO DEPLOY: `wt
  rp`, `wt w8` until it should show, check it live, `wt done`.
- Finished = merged, verified live, and announced if users or the team
  see it. Announcing is my call: draft the post, `wt ra`, wait; I say
  send (post, then `wt done`) or not needed (`wt done`). `wt done` /
  `wt cancel` are reversible (`wt resume`): run them yourself, never
  ask. `wt forget` is the only destroy.
- `wt night`: told to work alone to the hand-back bar on your own
  recommended answers (stop on the draft PR where a design choice
  is open, unless `/rd` or the `rd` label).
  Finished: say so and stop, no invented work. Follow-up tickets:
  `wt night queue <url>`.
- An isolated subagent's worktree is swept after a day: cherry-pick
  what you keep into your branch right away.
- `wt id` prints the slug, to point another agent at you.

## Telling another agent

`wt-tell <worktree path> <key> <ping> <prompt>`: the goal and why in a
few sentences; it picks the how. No file lists, steps or "every X":
it follows them literally. One tell per key; a correction is a new
key. Exit 1 with no output = busy, nothing delivered: retry later.
Idle chats get closed after an hour; a tell resumes them.

## Inbox

`notify` (via `ping-me`, hooks) appends to a per-pane inbox; my reply
clears a Claude row. Keys: `M-i` next pending, `M-k` focus this
worktree, `M-u` later, `M-o` picker, `M-y`/`M-r` mark done. `wt-cold` pings
me for every stalled item, so an empty inbox means nothing waits on
me: never add a state that lets work go quiet.

Priorities: `$LOCAL_CONFIG/priorities` (`prio`, `prio add`). Their
tickets come from Linear groupings (project, parent, label): a ticket
you file for a priority's work goes in that priority's grouping.

## Claude accounts

`cswap` switches logins (auto near the usage limit). After a swap,
artifacts from the other login read "not found": when the work needs
one, republish it under the active login (`/repa`) and update that
copy from then on; don't report it or ask me to share. A "Stopped
watching Artifact … (not found)" notice needs nothing: end the turn
at once, no tool call, no text. Listing artifacts = Artifact `list`
plus `artifacts` (across logins); name the login on each link you
report unless it's shared.
Borrowed logins (any not in `$CSWAP_RC_ACCOUNTS`: an email naming
someone else can still be mine) never publish artifacts, use the
Slack connector (it acts as them) or Remote Control; hooks refuse. An
artifact: report the local path, SendUserFile it. A Slack post (on my
word, as always): `slack-post`, which posts as me and watches replies.
