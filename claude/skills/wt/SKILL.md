---
name: wt
description: "How my worktrees, board, notification inbox and Claude logins work: `wt` (add/fix/feat/review/rm/done/cancel/rt/rd/rp/ra/rb/fx/sz/w8/ip/merged/night/resume/clean/pin), the board order files, `wt-sync` and `wt-tell` tells, `notif`/`notify` and the M-i/M-k/M-u/M-o/M-y keys, `cswap` accounts, and one unit of work (ticket + branch + worktree + session + agent + board row). MUST load before running any `wt`, `notif` or `cswap` command, when starting (a code fix asked for mid-chat too, before the first `wt`), parking, blocking, finishing or splitting work ('this is blocked by X', 'it's done', 'do that in a follow-up', 'split it', 'once this ships', 'stack a PR on this one'), before answering where work is happening or what is on the board, before listing artifacts or when one reads \"not found\" or \"no access\" (a login swap), and before changing those scripts."
---

# wt, notifications, accounts

One piece of work = ticket + branch + worktree + tmux session
(worktree slug) + agent in its `cli` window + board row. `wt` moves
them together; never move one by hand (raw git, the ticket's state
in the UI, renaming sessions). Run every step unasked.

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
- A design question for me (flow skill, picking-up node): `lin state
  "Owner review"`.
- `wt` acts on the pane's own worktree; for another session,
  `tmux send-keys -t <slug>:1 'wt …' Enter`.
- Which wait: the flow skill's waiting node. `wt rb
  <worktree|ticket|#pr>` (never free text: nothing lifts it; a PR or
  a worktree's PR lifts it when it merges, closes or another PR
  carries it), `wt w8
  <estimate> "<what>"` (`wt w8 done` when it arrives; other tells
  don't end it), `wt sz <when>` (nothing else schedules a wake-up).
- My next step needs real focus (manual setup, a direction check):
  `wt fx "<what I must do>"`.
- Park: `wt rt` team review, `wt rd` ready to deploy, `wt rp` prod
  review, `wt ra` to announce, `wt ip` back in progress.
- PR merged: you get told; run what `jrb-hook merged-hint` says.
  A deploy or rollout tell that says it is handled already: one line
  saying so, stop. Where
  the merge is the release (a tooling repo), not READY TO DEPLOY: `wt
  rp`, `wt w8` until it should show, check it live, `wt done`
  (in a repo marked `wt.live`, `wt done` and `wt ra` refuse until
  repo-sync has the merge commit in the main checkout).
- Finished and announcing: the flow skill's waiting and announce
  nodes; a customer post waits in `wt ra` for my send. `wt done` /
  `wt cancel` are reversible (`wt resume`): run them yourself, never
  ask. `wt forget` is the only destroy.
- `wt night`: told to work alone on your own recommended answers,
  as far as the flow skill takes you. Finished: say so and stop, no
  invented work. Follow-up tickets: `wt night queue <url>`.
- An isolated subagent's worktree is swept once it and the session
  that spawned it sat idle 72 hours: cherry-pick what you keep into
  your branch right away.
- `wt id` prints the slug, to point another agent at you.

## Start new work

What to ask: the flow skill's starting-new-work node. Mechanics:
`WT_NO_ATTACH=1 wt fix|feat <url>`, with `WT_PROMPT_EXTRA` for what's
known; the branch starts at current HEAD, so a follow-up that needs
this PR's code runs it from this worktree, then `wt rb <this-slug>`
in the new session. Brief the new agent: `ListAgents`, its
`interactive` row, `SendMessage`, the brief opening with its flow
node. A branch switched in an old
worktree or `wt add` with free text leaves the board out of sync.

## Telling another agent

When and what: the flow skill's telling-another-agent node.
`wt-tell` mechanics (keys, revive, busy): the script's header.

## Inbox

`notify` (via `ping-me`, hooks) appends to a per-pane inbox; my reply
clears a Claude row. Keys: `M-i` next pending, `M-k` focus this
worktree, `M-u` later, `M-o` picker, `M-y`/`M-r` mark done. `wt-cold` pings
me for every stalled item, so an empty inbox means nothing waits on
me: never add a state that lets work go quiet.

Priorities: `$LOCAL_CONFIG/priorities` (`prio`, `prio add`). Their
tickets come from Linear groupings (project, parent, label).

## Claude accounts

`cswap` switches logins (auto near the usage limit). After a swap,
artifacts from the other login read "not found": when the work needs
one, republish it under the active login (`/repa`) and update that
copy from then on; don't report it or ask me to share. A "Stopped
watching Artifact … (not found)" notice needs nothing: end the turn
at once, no tool call, no text. Listing artifacts = Artifact `list`
plus `artifacts` (across logins); name the login on each link you
report unless it's shared.
Borrowed logins (any not in `~/.config/cswap-rc-accounts`: an email naming
someone else can still be mine) never publish artifacts, use the
Slack connector (it acts as them) or Remote Control; hooks refuse. An
artifact: report the local path, SendUserFile it. A Slack post (on my
word, as always): `slack-post`, which posts as me and watches replies.
