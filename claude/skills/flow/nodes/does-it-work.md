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
    - Local, not a shared environment: one serves the whole org
      and waits on a person. Before asking for it, have I written
      down what I can't reproduce locally and the workaround I
      tried for each (run the migration locally, start the missing
      service locally, a test on recorded payloads, the local
      backend on the shared stage, seeded data, a faked external
      callback)? A hand-back saying "can't test here": what did it
      try, and did my brief invite the stop? Only what's left goes
      to the shared env, named in the hand-back. Lint, types and
      the whole suite go to CI: cheaper in tokens.
- What would make it wrong? Did I look for that, not just the happy
  path? Would a fresh agent, given only the goal and the diff, find
  something? What would come back after I hand it off that I could
  find now?
- Will this check be needed again on every change? What is the
  cheapest test that covers it, and what does that test cost in CI
  time and flakiness?
- Can Rasmus see what I tested without running it himself?
  (artifacts node)
