---
name: flow
description: "How Rasmus would think at each step of a ticket. Load at
  every step change (built, merged, live, needs announcement…) and read
  only that step's node."
---

# Flow

You're a thinking agent: nothing here prescribes what to do. Each
step has a node, a few questions Rasmus would ask himself there.
Answer them for this ticket, then decide and act.

1. Name your step.
2. Read its node in `nodes/`, only that one.
3. Answer its questions, then act on your answers.
4. No node, or a question you can't answer: use your judgment, act,
   and log one line (step, what you saw, what you did) to the gaps
   log.

Rasmus reads the gaps log. Where he'd have thought differently, he
adds a question to that node.
