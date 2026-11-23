# Starting new work

- Is it new work, or part of what this session is building
  (asked-for-a-change node)? New work gets its own worktree agent,
  started this turn, before any edit or subagent. A small ask from
  a screenshot is still new work. The start command itself launches
  that agent on the ticket: who investigates, this session or it?
- Is there a ticket, claimed where teammates see it (the repo's own
  claim step), and one worktree per ticket id?
- Does it start from the base, or stacked on another PR's branch?
  Stacking blocks it on work that may not really block it, and with
  many agents on the same kind of work, most would wait. Can it copy
  the code it needs instead, noting in its doc what it copied from
  which ticket, and the names and types it builds on from them? At
  rebase that list is the base of a three-way look: changed upstream
  only, adopt upstream's; changed here on purpose, keep it and
  judge; both, decide. No rename has to be told to every copier.
  Before shipping ahead of upstream, the copier asks: am I confident
  enough in the copied change to cut the line? Then it rebases on
  upstream's merge and goes green again before it ships: a lane green
  against its copy broke dev once upstream merged a changed contract.
  Stack only when it can't move without that code (then retargeted
  once it merges).
- What does the agent need that the ticket lacks: what was decided
  and rejected, and why, in whose words? Prior PRs or branches to
  port? Where to look?
- Am I giving it the goal and why, and letting it pick the how? A
  file list, steps, "every X" or a rule ("never ask", "no dev
  servers") get followed literally, over the flow it would follow.
  Does the brief open with the flow node it starts at, my plan as
  input to that node?
- Once it's started, is my part over? It already works the
  ticket, so an edit I make in its worktree is a second agent on
  the same change. What I found goes to it as a message instead.
  Its notifications reach Rasmus; report the ticket, slug and
  brief (its doc: `wt doc <slug>`), then stop.
