# CI red, a gate refused, or a review came in

- Is it my change, or the base, a flake, something others hit too?
  Is someone already fixing it (an open PR, another agent)? Then
  wait on theirs (waiting node), don't fix it twice.
- What does it tell me about the change? Does it lower my
  confidence (is-it-good node), or only block the merge? A review
  comment: is it real, and would a user notice the difference?
- Here, or a follow-up? Would the push restart CI and reviews for
  little gain while others wait?
- Who writes the fix: does it need what I hold in context, or a
  fresh agent briefed with the finding (the repo's rule on who
  writes code)?
- How many rounds is this? The same kind of failure again: what's
  different this time? Is the design the problem?
- Once it's green: does the plan from before still hold (the ship
  date, the scope), or was it only carried over?
