---
name: swarm
description: "Fan a set of tickets out to one Claude agent per worktree and babysit them until each is done or blocked — '/swarm <goal>', 'make progress on all my Linear tickets in Todo', 'work my tickets overnight', 'put an agent on each of these', 'monitor these worktrees'. Creates worktrees with wt, briefs each agent to /iterate alone, throttles concurrency so the machine survives, and unsticks agents caught on prompts."
---

# Swarm

One agent per ticket, each in its own worktree, each running its own
`/iterate`. You are the supervisor: you launch, watch and unstick.
You never build in their worktrees. Load `iterate` for the loop and
`work-status` for every report.

Reliability beats throughput. One night we ran 9 agents at once with
no throttle, they all hit tsc/jest at the same moment, the Mac ran
out of memory and the watchdog rebooted it 13 minutes in. All work
stopped until morning.

## Scripts (in this skill's dir)

- `launch <worktree> <issue-url> [--resume] [extra]` briefs the
  agent in the worktree's tmux `cli` window from `brief.md`, without
  attaching. If Claude is running it interrupts and sends the brief,
  otherwise it starts `claude [-c]`. It records the session in
  `~/.cache/swarm/sessions.tsv`.
- `peek` prints one line per session: dead, question, permission,
  busy or idle, plus PR number, free memory and busy `heavy` slots.
- `heavy <cmd>` (dotfiles `bin/`) runs a command in one of
  `HEAVY_SLOTS` (default 3) slots shared by the whole machine. The
  brief tells every agent to wrap tsc, jest, eslint and builds in it.

## Steps

1. **Resolve the set** from the goal. Linear: `assignee: me`, with
   the statuses named. "Todo or higher" means Todo + In Progress.
   Owner review and later stages are waiting on a human. If the user
   is about to leave and something is genuinely ambiguous, ask once,
   up front, with AskUserQuestion. After that, no questions.
2. **Dedupe each ticket before creating anything.** Tickets move
   between teams and keep their old branch (POL-1921 became EXP-48,
   POL-2038 became EXP-232). Check `git worktree list`, the board
   file, and `rg -l '<ID>|<title words>' ~/.claude/projects`. If a
   worktree already exists, reuse it with `launch <path> <url>
   --resume "<what it is>"`.
3. **Pick concurrency.** Away or overnight: at most 3
   agents at once, and start the next as one goes done or blocked.
   Present: more is fine, since `heavy` caps the expensive part.
   Don't launch a new agent when free memory is under about 8 GB.
4. **Create** with `wt fix|feat <url> </dev/null`, then run `launch`
   on the new path. Stagger launches by about 20s.
5. **Queue:** use `temp_queue/swarm/INDEX.md` in the repo, after
   checking `git check-ignore -v`. One line per ticket with its
   session, state, PR and blockers.
6. **Tick** every 20 min with ScheduleWakeup. Run `peek` and act on
   each state:
   - **question** (AskUserQuestion): press Escape. Tell the agent to
     take its recommended option and log the decision for Rasmus.
   - **permission**: press Escape and **never approve**. Tell it to
     route around the command (no production) or record it as
     blocked.
   - **dead**: run `launch --resume`.
   - **idle with no PR, nothing blocked**: nudge it to continue.
   - **idle with a PR or blockers**: done. Pull out its questions:
     `tmux capture-pane -pJ -S -150 -t "${s}:cli" | awk '/Blocked on
     you/{f=1} /Blocked on something|Found along/{f=0} f'`. Then
     start the next queued ticket.
7. **Stop** when every ticket is done or blocked. The final board
   lists each agent's blocked questions verbatim, with its PR.

## Gotchas

- Grey text in an idle agent's prompt box is Claude's own suggestion.
  Nobody sent it, so the agent is still waiting. Check for `ESC[2m`
  with `capture-pane -e`.
- `peek` treats a `◯ builder …` row as busy. The main loop is idle,
  but a background subagent is still working.
- Never type a brief straight into a shell. zsh evaluates backticks
  and `$(…)`, and once ran `heavy yarn typecheck` instead of starting
  Claude. `launch` passes the brief as `"$(cat file)"`.
- In zsh, `"$s:cli"` applies the `:c` modifier. Always write
  `"${s}:cli"`.
- Claude's input uses vim mode, so a single Escape can leave it in
  NORMAL. `launch` sends `i` before typing. Never send a double
  Escape: on an empty prompt it opens rewind.
- `wt` speed-dial collision: if a slot is blank but its `<repo>[N]`
  session is still alive, `wt fix` takes the slot, attaches to the
  stale session and starts no Claude. `launch` finds sessions by
  path, so the agent still starts, but move the board entry into
  `# IN PROGRESS`.
- `wt rm` and messaging another agent can be refused by the auto-mode
  classifier. Leave those for the user and don't route around them.
- tmux comes back after a reboot, but the sessions only have shells
  in them. `peek` shows them as dead, and `launch --resume` picks the
  agent's context back up with `claude -c`.
