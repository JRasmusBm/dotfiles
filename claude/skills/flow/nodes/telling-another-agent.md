# Telling another agent

A handoff, a finding, a correction, a brief for a session that
already runs.

- Is anyone already on it? `ListAgents` and the worktree's tmux
  panes say who runs where; a start command may have launched one.
  Two agents on one change is the thing to catch.
- Is its session live? A live one gets the message now, queued if
  it's busy. A closed chat needs reviving first (`wt-tell`). A busy
  answer is not a no: is there a way that queues instead of a retry?
- Is what I pass on settled, and by whom? Rasmus asking or
  thinking aloud is not a decision to relay.
- Does the first line say what this is, for the human who sees only
  that line? Does it then name the flow node the receiver is at
  ("Flow skill, waiting node."), with my plan framed as input to
  that node? A plan alone gets followed literally, flow unread.
- What does it need that it can't see: what I changed (commit),
  what I checked and what I didn't, the sources (paths, links), who
  owns the work from now?
- Am I relaying through Rasmus something the agent could get
  straight from me?
- Is my part over once it's sent? Say so in the message, then stop.
