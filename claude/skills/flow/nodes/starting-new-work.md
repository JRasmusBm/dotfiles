# Starting new work

- Is it new work, or part of what this session is building
  (asked-for-a-change node)? New work gets its own worktree agent,
  started this turn, before any edit or subagent. A small ask from
  a screenshot is still new work. The start command itself launches
  that agent on the ticket: who investigates, this session or it?
- Is there a ticket, claimed where teammates see it (the repo's own
  claim step), and one worktree per ticket id?
- Does it start from the right code: the base, or this PR's branch
  because it needs this code (then blocked on this one, retargeted
  once it merges)?
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
