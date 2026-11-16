# Asked for a change, or found one

- Is there a ticket that covers it? Check ownership.
- Can the change be built in this PR without scope creep? Build it
  here.
- Will the current release lead to a poor/pointless experience for
  the user without the change? Build it here.
- Otherwise, would it make more sense in another PR?
  - Create the ticket (see the drafting-a-ticket node) if it doesn't
    exist.
  - Start the agent with `wt feat/fix <ticket-url>`.
