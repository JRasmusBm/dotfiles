---
name: work-management
description: "How Rasmus manages work: one unit of work = Linear ticket + branch + worktree + tmux session + agent + board row, kept in sync by `wt`. MUST load when starting (including a code fix asked for mid-chat, before the first `wt`; loads alongside claim-work, never instead of it), parking, blocking, finishing or splitting work: picking up a ticket, moving it to review/deploy/prod check, 'this is blocked by X', 'snooze it until monday', 'it's done', or whenever you and Rasmus agree (or he asks) that something goes in a follow-up ticket or PR ('do that in a follow-up', 'split it', 'once this ships', 'put it behind a release flag and create a follow-up PR to release to everybody', 'stack a PR on this one'), or you're about to propose one."
---

# Work management

One piece of work is six things that must agree: a Linear ticket, a
branch, a worktree, a tmux session (named by the worktree slug), an
agent in its `cli` window, and a row on the board (`wt :`). `wt`
moves them together; never move one by hand (raw git, Linear UI
state changes, renaming sessions). Command details: the Worktree
Workflow section of `~/CLAUDE.md`.

This is Rasmus's personal setup (local wt, his Linear tickets), so
nothing here goes in a repo. Run every step of a flow without being
asked for each. Steps with no arrow between them run in parallel.

## Lifecycle

| Moment | Command | Board | Ticket |
|---|---|---|---|
| Start a ticket | `wt fix\|feat <url>` | IN PROGRESS | (kickoff prompt) |
| Review someone's PR | `wt review <pr>` | IN PROGRESS | — |
| My PR ready (green) | `lin state "Owner review"` | IN PROGRESS | Owner review |
| He sends it to the team | `wt rt` | TEAM REVIEW | Team review |
| Approved | `wt rd` | READY TO DEPLOY | Ready to deploy |
| He says "merge #N" / "ship #N" | conveyor `ship_pr` (`until=merged` / `deployed` + targets), then end the turn | (tells move it) | (tells move it) |
| Deployed, check prod | `wt rp` | PROD REVIEW | Needs live verification |
| Waiting on other work | `wt rb <blocker>` | BLOCKED | Blocked + relation |
| Can't merge yet: design review, risks to settle, someone's decision | `wt rb "<reason>"` (I run it when I hand back, naming who and what) | BLOCKED | Blocked |
| Waiting on a date ("snooze it until monday") | `wt sz <when>` | SNOOZED | unchanged |
| Picking it back up | `wt ip` | IN PROGRESS | In Progress |
| Finished | `wt done` | (removed) | Done |
| Dropped, won't do | `wt cancel` | (removed) | Canceled |
| Abandon, keep history | `wt rm` | (removed) | unchanged |
| Bring back | `wt resume <slug>` | — | — |

- These act on the worktree of the pane they run in. For another
  session: `tmux send-keys -t <slug>:1 'wt …' Enter`.
- Unblocking is automatic: removing the blocker (`rm`/`done`/
  `cancel`/`clean`) moves the blocked one back and notifies its `cli` pane.
  Waking is the same, driven by the date instead: any `wt` run on
  or after it moves the worktree back to the section it was snoozed
  from and pings it; a blocked one also wakes when unblocked. Snooze is for
  "not before Monday"; `rb` is for "not until that ships".
- `wt done`/`cancel` refuse to remove anything if Linear isn't updated;
  the others are best-effort, so check their output.
- Pointing another agent at this work: `wt id` (the slug).

## Shipping and the tells

In a repo with the conveyor MCP (ice-floe), merging and deploying to
production go through it, and only on his word. `ship_pr` answers
`checking`, `ready` or `rejected` right away; an immediate rejection
I fix now. Otherwise I end the turn, without the 2-minute
`get_ship_status` poll the repo's `dev-workflow` asks for: `wt-sync`
follows every state change and tells this agent once per change, so
he never has to nudge it. Each tell is the next step:

| Tell | What I do |
|---|---|
| merged (`pr-merged-tell`) | double-check the conveyor (`get_ship_status`), `wt merged` (it parks in NLV when the conveyor is shipping it, else RTD); not shipping → tell me how you'd ship it (`ship_pr`) |
| conveyor rejected | fix what it says, `ship_pr` again with the same `until` and targets; needs a person → `wt rb "<who and what>"` |
| conveyor failed | read-only: timeline, deploy run, rollout; report and recommend, never re-ship or roll back alone |
| partly / fully on staging or prod | verify read-only there; prod verified → draft the announcement, `wt ra`, wait for my send or not needed |
| needs no deploy | check where it runs, draft the announcement, `wt ra`, wait for my send or not needed |

A tell for something already handled: one line saying so, then stop.
Staging still goes through `tb` (the conveyor is production only), and
`deploy-plan`/`pr-where` count both kinds of deploy.

## Start new work

When he asks to start something ("please start it", "kick this off"),
or asks for a code change mid-chat ("can we fix that?", "can we
convert it instead?") while I'm on the main checkout or a feature
branch that has nothing to do with the ask. A fix that grows out of
an investigation is new work too, and so is a bug in work whose PR
already merged, even its own ticket's: a new ticket related to the
old one, never a branch switched or created in the old worktree. So is work that began in the main
checkout and turned out to matter (an incident, a migration, a
customer fix he keeps returning to): he has no time for the steps
then, so I take them unasked, as soon as I see it: ticket (claimed,
linking the Slack thread), `WT_NO_ATTACH=1 wt fix|feat <url>` with
`WT_PROMPT_EXTRA` carrying what's known and done so far, then one line
to him with the slug. That puts it on the board, in the tells and in
`wt night`. Never build it in the current
checkout, and never run `wt add` with free text in place of a ticket.
A scoping or ideation ticket is work too: it gets a worktree and
agent in the same turn, and that agent's output is started build
tickets (Follow-up flow, steps 3–4), not a doc. It may kick off a
brilliant idea before he picks, briefed to `/iterate` to a ready
PR; an unwanted one costs a `wt cancel`.

1. **Claim.** Nobody else may already be doing it. If the repo has
   a `claim-work` skill (ice-floe does), load it and run its check
   and claim; it's the team's shared rule on who owns what, so it
   wins there. Not on where a new ticket goes: a POL subteam, never
   POL itself unless he asks. EXP (Experience: agents, dashboards,
   connectors, UX) or PLA (Platform: data infrastructure), picked
   by the team description. Search wider than it does, too:
   - `list_issues` across every team, not only POL: tickets get
     moved and renumbered (EXP-, PLA-)
   - the board and the disk: `wt :` rows plus `git worktree list |
     grep <noun>`, since an In Progress ticket has a worktree
   - colleagues' open PRs: `gh pr list --search <noun>`
   Someone else owns it → stop before any `wt`, tell him who, with
   the evidence (when he's away: park it as blocked, don't ask).
   A ticket of his, or one with no owner, that covers the ask, or
   part of it, is the ticket: assign it to him and widen its scope
   rather than filing a second one. Partial overlap: link it as
   related and say so in the report. No hit: create one, with the
   problem and what we decided in chat. Either way, In Progress.
2. → **Worktree + agent** (needs 1): `WT_NO_ATTACH=1 wt fix|feat
   <url>`. The branch starts at the current checkout's HEAD.
3. → **Brief it** (needs 2): `ListAgents` and find the new session
   by slug. When two rows share the name, pick the `interactive`
   one, not the Remote Control one. `SendMessage` it everything
   from this chat that the ticket lacks:
   - what's decided, and what was rejected and why
   - prior PRs or branches to port from (don't push to someone
     else's PR)
   - files and line pointers
   - to rebase onto origin/dev if HEAD wasn't dev
   - "decided, don't grill" when the design is settled
   - "already claimed as <ticket>": its `claim-work` check finds
     his own ticket and carries on, without claiming a second time
   - when he's away ("I'm off for the weekend"): never block,
     use `iterate`, go to a ready PR against dev and run
     `/iterate-review` until clean (it marks the PR ready, and
     that beats any "draft" wording), ticket → Owner review,
     open questions in the PR body, never merge. It's how he spends
     spare tokens: on a 5h/session limit, wake at the reset and
     go on; stop only when the weekly limit runs out. Keep the
     Mac awake (`caffeinate -ims -t <secs>`, detached). A turn
     cut by sleep leaves the agent idle: nudge its `cli` pane
     with `send-keys "<text>"`, then a separate `send-keys C-m`
     (Enter in the same call lands as a newline). That
     brief is enough; no `swarm` babysitting. Slack saved-for-
     later items and his Linear Todos are one queue: triage both.
     Prod/staging infra changes, purchases and date-gated steps
     stay with him.

Report: ticket link, slug, the gist of the brief. The brief ends my
part. Don't watch the agent (no `notify_when_idle`, no asking it to
report back to me): its own notifications reach Rasmus's inbox.

## Follow-up ticket and PR

Only when he asks, or explicitly agrees in chat, that
something is done in a follow-up rather than in the current
PR. Never split on my own: a ticket step that waits on
another PR stays in this ticket (hold the PR, or add it after
a rebase). Unsure → ask with options, don't split. A
follow-up that only lives in chat or a PR comment gets lost,
so it always becomes a ticket with its own worktree and agent.
Same for tickets I file for findings outside this PR's scope
(review leftovers, bugs seen along the way): start each one
in the same turn I file it. A ticket with no agent is the
failure here, never the cautious choice, since an unwanted
one costs him one `wt cancel`; filing before he steps away
and leaving them idle wastes the whole night.

1. **This PR.** Do whatever makes the split work here (e.g. a
   temporary flag), commit, push, and say in the PR body what is
   left for the follow-up.
2. **This ticket.** Patch its description with one short line:
   what was split out and why. Patch, don't rewrite.
3. **Follow-up ticket.** Search for an existing one first, as in
   Start new work step 1. Same team, project and assignee; blocked
   by this ticket. Says what to do, where (files), what stays, and
   what unblocks it (merged, deployed, Rasmus's OK after prod…).
4. → **Worktree + agent** (needs 3): `WT_NO_ATTACH=1
   WT_PROMPT_EXTRA="…" wt feat <follow-up url>`.
   - Needs this PR's code → run it from this worktree, so the
     branch starts at this branch's tip; the agent opens a draft
     PR with base = this branch, and retargets to dev (after a
     rebase) once this PR merges.
   - Independent → the PR targets dev.
   The extra prompt says: decided, don't grill; build it; never
   mark ready or merge while blocked.
5. → **Block it** (needs 4): `tmux send-keys -t <new-slug>:1 'wt rb
   <this-slug>' Enter`. Also moves the follow-up ticket to Blocked.

Report: PR link, both ticket links, the new session's slug.

### Example: release flag, then release to everybody

"Put it behind a release flag and create a follow-up PR to release
to everybody." That one sentence is the whole brief: step 1 adds a
localStorage key in `LOCAL_STORAGE_KEYS`, named `pa-show-<thing>`
(show, not with), default off, checked once in the access hook so
every surface follows it. The follow-up removes the key; it is
unblocked by Rasmus's OK after looking in prod.
