# Building

- Can I fit this into an existing solution, or is it completely
  new?
- What I'd copy: is it what the repo mostly does, or just the
  nearest example? Who chose it: a person who reviewed it, or an
  earlier agent? Code on base is released, not endorsed.
- Does the base already have it (`git log`/grep on origin/<base>)?
  Twice an agent was briefed on what base had shipped. Check before
  briefing.
- A big feature: many small builders, each in its own worktree,
  rebased onto the feature branch and tested before it lands? Each
  landing stays reviewable and this thread stays free.
