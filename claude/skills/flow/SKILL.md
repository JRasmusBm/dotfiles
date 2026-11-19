---
name: flow
description: "How Rasmus would think whenever deciding what to do
  next: picking up a ticket, finding a change, judging whether it's
  good or shipping it, CI red or a review in, merged or deployed,
  telling people or agents, waiting or ending a turn, learning
  something. Most of all when the prompt already says what to do (a
  tell, a brief, a wait's deadline): give that moment to a subagent,
  which reads only its node."
---

# Flow

You're a thinking agent. Nothing here tells you what to do: these
are the questions Rasmus would ask himself. Whenever deciding what
to do next, answer them fresh for the work in front of you, then
decide. An answer from an earlier step is not an answer, and neither
is a next step someone wrote for you: a tell's "fix it, push",
"carry on", a launch brief's rules, the plan in my own wait note or
last message. Those are input to the node, not its answer.

Any step, give it to a subagent with the following considerations:

- Does Rasmus have to step in here, or can I unlock it myself?
- What step am I at? Which node below fits?
- Does this step need what I've built up in context?
- What do I want the agent to report back? How would I know a report is wrong?
- Have my assumptions changed since I started? (Another PR taking it
  in a different direction, the ticket changed, it stalled long
  enough that it no longer matters.)
- Have I been at this step before for this work? What's different
  this time, and if nothing is, why would the result be?

- Nothing here fits, or I stretched a node to make it fit? Then a
  node could be missing: what question would have helped? Tell
  Rasmus as the waiting node says, with the node or question I'd
  add. Once he decides, record it: a new node, or an edit to an
  existing one.

## Nodes

Each node can have a private half at `~/.private/jrb/flow/nodes/`
under the same name: the work specifics (tools, repos, teams) that
can't be public. Read it with the node when it exists.

- Asked for a change, or found one → `nodes/asked-for-a-change.md`
- Writing a ticket → `nodes/drafting-a-ticket.md`
- Picking up a ticket → `nodes/picking-up.md`
- Starting new work or a follow-up, briefing an agent →
  `nodes/starting-new-work.md`
- Handing off, or another agent should know something →
  `nodes/telling-another-agent.md`
- Built, checking it works → `nodes/does-it-work.md`
- CI red, a gate refused, a review came in → `nodes/red-check.md`
- Showing Rasmus a page (an artifact: what I tested, a decision,
  a report) → `nodes/artifacts.md`
- Tested, deciding whether to ship → `nodes/is-it-good.md`
- Merged or deployed, checking it works in prod → `nodes/live.md`
- Infra to apply by hand → `nodes/applying-infra.md`
- Live, deciding whether to tell people → `nodes/announce.md`
- About to end a turn or wait → `nodes/waiting.md`
- Learned something worth remembering → `nodes/learned-something.md`
