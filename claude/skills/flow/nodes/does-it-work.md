# Built: does it work?

- Have I understood the problem to be solved? Or just acting on
  instructions? How sure am I it's the root cause, and what couldn't
  I verify? Does the hand-back say so?
- Have I considered the change holistically, including side effects
  and UX?
- Who uses this, and for what? Am I confident it works when used the
  way they would?
    - An MCP tool: have I called it as an agent would, with the
      questions people actually ask?
    - A page: have I opened it in a browser, or is it covered by an
      (end-to-end) test?
    - What actually runs my branch there, and what still runs base
      (a service I didn't start locally, a shared deploy)?
    - A long click-through: does it go to a fresh, smaller subagent,
      with me judging its screenshots, not its verdict?
    - Can I verify this locally, on up-to-date code? If so, that is
      preferred: staging is one resource shared by the whole org.
      Except lint, type checks and the whole test suite: CI runs
      those cheaper in tokens.
- What would make it wrong? Did I look for that, not just the happy
  path? Would a fresh agent, given only the goal and the diff, find
  something?
- Will this check be needed again on every change? What is the
  cheapest test that covers it, and what does that test cost in CI
  time and flakiness?
- Can Rasmus see what I tested without running it himself?
