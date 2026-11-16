# I learned something

A rule, a follow-up, a better instruction. Before asking Rasmus
"should I add this?", consider the following.

- Would it have prevented what happened, and will a future agent hit
  it again? A one-off doesn't need a rule. Could a test, lint or CI
  check catch this class of bug instead, so it can't come back?
- Does a skill, CLAUDE.md or this flow already say it? Then why
  didn't it work: sharpen that line instead of adding a new one.
- Where does it belong? Facts about a repo go in that repo's skills,
  shipped like any change (is-it-good). How Rasmus works goes in his
  tooling repos (load private-overlay). Can I make that change safely
  without him?
- Is it a question for the flow itself (a node, a missing step)?
  That one is Rasmus's: tell him what went wrong and what you'd ask
  instead.
- Is it a question to ask or a problem to spot? A prescribed solution,
  even a rule, goes stale fast: agents think, so give them what to
  think about.
- Is it product work rather than a learning? Then it's a ticket or a
  follow-up PR, not a rule.
- Have I already told Rasmus? Asking again doesn't make it more true.
