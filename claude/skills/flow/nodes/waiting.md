# Waiting or stopping

Before ending a turn, consider the following. A turn that ends on
"waiting for X" with no `wt rb`, `wt w8` or `wt sz` set is a wait
nobody ends: which one did I set?

- Is anything left that I could do myself? Then it isn't a wait.
- What exactly am I waiting on: CI, a deploy, another PR, my own
  background agent, a person, a date? Who or what tells me it's
  over?
- Waiting on another ticket or PR? Check its status, then `wt rb
  <ticket|#pr>`: I get told when it ships, closes, or another PR
  carries it.
- Waiting on something else that isn't Rasmus? Then `wt w8 <deadline>
  "<what>"`, so the wait has an end someone checks. `<what>` names
  the event, not the step after it: that step gets decided fresh
  when it arrives.
- Is the wait long (an hour of logs, a soak)? A subagent's hooks
  block sleeps and polling loops, so it returns early with
  nothing: the wait stays in this thread (`wt w8`), and the
  subagent gets only the check to run once it is over.
- Is it a person? Have I asked them, where they will see it?
- Is this finished: merged, verified live, announced? Then close
  it, don't leave it open.
- Am I waiting for Rasmus? If so, will he be able to tell from the last section
  in the thread exactly what I need from him so he can unblock me quickly
  and effectively? A direction or testing check: can he do it in two
  minutes from a local page (artifacts node)?
