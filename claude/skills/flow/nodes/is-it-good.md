# Tested: is it good to ship?

Before asking Rasmus "is it good?", consider the following.

- Can I find out (and thus make the change) safely without asking Rasmus? Include him if sensitive!
- Does it work? (does-it-work node)
- Does it fix a message (an error, a refusal, a log line)? Which
  other code produces that text: the message grepped, its
  formatter's callers, sibling tools? Does the failure's alert or
  log query over the last 7 days show it from code this fix doesn't
  touch? Cover them, or name them in the PR.
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
- Is a code freeze on (check the team's channels), or a high-stakes
  period close for the business? Then don't ship: park it
  and hand back. Only Rasmus calls something an urgent fix. A
  snooze, a "ship tomorrow" or a brief set before the freeze
  doesn't override it.
- Will the things I don't know be easy to change? (For example be wary of a big
  UX change that I'm not sure about)
- Has a fresh adversarial reviewer read the whole branch once, even
  an unattended one? One found a deleted record's text surviving in
  copies of it.
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
