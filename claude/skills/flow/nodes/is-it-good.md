# Built: is it good?

Before asking Rasmus "is it good?", consider the following.

- Can I find out (and thus make the change) safely without asking Rasmus? Include him if sensitive!
- Have I understood the problem to be solved? Or just acting on instructions?
- Have I considered the change holistically, including side effects and/or UX?
- Who uses this, and for what? Do I have confidence that it will work when used
  the way they would? 
    - An MCP tool: have I called it as an agent would, with the questions people actually ask?
    - A page: have I opened it in a browser or is it covered by an (end-to-end) test?
    - Can I verify this locally, on up-to-date code? If so, that is
      preferred: staging is one resource shared by the whole org.
- What would make it wrong? Did I look for that, not just the happy
  path? Would a fresh agent, given only the goal and the diff, find
  something?
- If it breaks, how badly? What would the impact be? (Do not accept
  incidents/breaking things). How (fast) can we recover? Too worrying
  to ship plainly: can it go out behind a feature flag and be tested
  in prod first?
- Will the things I don't know be easy to change? (For example be wary of a big
  UX change that I'm not sure about)
- Am I highly confident it's an improvement (a step in the right direction is
  fine), holistically and relative to the problem, with CI green (including AI
  reviewers)? Then ship it.
- Not confident: is the design the problem? Back to the drawing board
  may be cheaper than more testing.
