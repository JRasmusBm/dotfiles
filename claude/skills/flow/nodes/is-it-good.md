# Tested: is it good to ship?

Before asking Rasmus "is it good?", consider the following.

- Can I find out (and thus make the change) safely without asking Rasmus? Include him if sensitive!
- Does it work? (does-it-work node)
- When does it reach users? Does merging release it, or does
  something else ship it (a shared image, a scheduled build, another
  person's deploy)? If merged means live whenever anyone builds, it
  is tested the way it will run before merge, not in a rollout I
  plan to do later.
- If it breaks, how badly? What would the impact be? (Do not accept
  incidents/breaking things). How (fast) can we recover? Too worrying
  to ship plainly: can it go out behind a feature flag and be tested
  in prod first?
- Could it run up a bill (warehouse queries, AI calls, something on
  a schedule)? What measures that cost for this project and pings
  past a threshold, before it runs without anyone watching?
- Is a high-stakes period close (e.g. BFCM for e-commerce)? Then
  nothing may break, freeze or not: how would this fail during it,
  and could I undo it in minutes? Is there a freeze? Check the team's
  channels. Holding it adds to what ships at once afterwards: is
  that safer?
- Will the things I don't know be easy to change? (For example be wary of a big
  UX change that I'm not sure about)
- Is the doc current, and does the PR body draw from it (problem,
  decisions, what was tested, as text) rather than a fresh
  write-up?
- Am I highly confident it's an improvement (a step in the right direction is
  fine), holistically and relative to the problem, with CI (if present in the
  repo) green (including AI reviewers)? Then ship it. A minor review comment on
  a green head: would the push restart CI and reviews while others wait on this
  (a red base)? Then ship the head, reply "follow-up", resolve, fix on another branch.
- Not confident: is the design the problem? Back to the drawing board
  may be cheaper than more testing.
