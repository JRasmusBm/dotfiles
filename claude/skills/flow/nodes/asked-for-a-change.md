# Asked for a change, or found one

- Is there a ticket that covers it, and is it claimed? Unclaimed,
  found or just created: claim it (the repo's claim step) and start
  its agent (starting-new-work node). Tickets don't sit.
- Can the change be built in this PR without scope creep? Build it
  here.
- Will the current release lead to a poor/pointless experience for
  the user without the change? Build it here.
- Otherwise, would it make more sense in another PR? Or is it one
  of many small changes to the same code while the design still
  moves? Then one branch we iterate on beats a PR each: each PR
  pays its own review loop.
  - Create the ticket (see the drafting-a-ticket node) if it doesn't
    exist.
  - Start its agent (starting-new-work node).
