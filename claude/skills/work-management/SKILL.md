---
name: work-management
description: "How Rasmus manages work: one unit of work = Linear ticket + branch + worktree + tmux session + agent + board row, kept in sync by `wt`. MUST load when starting, parking, blocking, finishing or splitting work: picking up a ticket, moving it to review/deploy/prod check, 'this is blocked by X', 'it's done', or whenever you and Rasmus agree (or he asks) that something goes in a follow-up ticket or PR ('do that in a follow-up', 'split it', 'once this ships', 'put it behind a release flag and create a follow-up PR to release to everybody', 'stack a PR on this one'), or you're about to propose one."
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
| PR up for review | `wt rt` | TEAM REVIEW | Team review |
| Approved | `wt rd` | READY TO DEPLOY | Ready to deploy |
| Deployed, check prod | `wt rp` | PROD REVIEW | Needs live verification |
| Waiting on other work | `wt rb <blocker>` | BLOCKED | Blocked + relation |
| Picking it back up | `wt ip` | IN PROGRESS | In Progress |
| Finished | `wt done` | (removed) | Done |
| Abandon, keep history | `wt rm` | (removed) | unchanged |
| Bring back | `wt resume <slug>` | — | — |

- These act on the worktree of the pane they run in. For another
  session: `tmux send-keys -t <slug>:1 'wt …' Enter`.
- Unblocking is automatic: removing the blocker (`rm`/`done`/
  `clean`) moves the blocked one back and notifies its `cli` pane.
- `wt done` refuses to remove anything if Linear isn't updated;
  the others are best-effort, so check their output.
- Pointing another agent at this work: `wt id` (the slug).

## Start new work

When he asks to start something ("please start it", "kick this off")
and I'm on the main checkout, or on a feature branch that has nothing
to do with the ask. Never build it in the current checkout.

1. **Ticket.** Create it in Linear and assign it to him: right team,
   with the problem and anything we decided in chat. If one exists
   already (e.g. a colleague filed it), reassign it to him instead.
   Either way, set it to In Progress.
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

Report: ticket link, slug, the gist of the brief.

## Follow-up ticket and PR

Whenever we agree, or he asks, that something is done in a
follow-up rather than in the current PR. A follow-up that only
lives in chat or a PR comment gets lost, so it always becomes a
ticket with its own worktree and agent.

1. **This PR.** Do whatever makes the split work here (e.g. a
   temporary flag), commit, push, and say in the PR body what is
   left for the follow-up.
2. **This ticket.** Patch its description with one short line:
   what was split out and why. Patch, don't rewrite.
3. **Follow-up ticket.** Same team, project and assignee; blocked
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
