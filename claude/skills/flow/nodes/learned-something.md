# I learned something

A rule, a follow-up, a better instruction. Before asking Rasmus
"should I add this?", consider the following.

- Would it have prevented what happened, and will a future agent hit
  it again? A one-off doesn't need a rule.
- Would an agent really apply it at that moment, or would it only
  make us feel covered? An instruction gets skipped deep in a long
  session and costs tokens in every short one. What would catch it
  for sure: a test, lint or CI check, or a script that measures it
  and pings past a threshold?
- Does a skill, CLAUDE.md or this flow already say it? Then why
  didn't it work: sharpen that line instead of adding a new one.
- Only write to auto memory for cross-project notes.
- Before editing any skill, CLAUDE.md or script, load the repo's
  `save-learnings` skill if it has one, and `private-overlay`.
- Where does it belong? Only where it bites: global context loads
  for every task, and teammates' work differs. Facts about a repo go
  in that repo's CLAUDE.md or skills/docs, shipped like any change
  (is-it-good). How Rasmus works goes in his tooling repos. Can I make
  that change safely without him?
- Is it a question for the flow itself (a node, a missing step)?
  That one is Rasmus's: tell him what went wrong and what you'd ask
  instead.
- Is it a question to ask or a problem to spot? A prescribed solution,
  even a rule, goes stale fast: agents think, so give them what to
  think about.
- Is it product work rather than a learning? Then it's a ticket or a
  follow-up PR, not a rule.
- Have I already told Rasmus? Asking again doesn't make it more true.
