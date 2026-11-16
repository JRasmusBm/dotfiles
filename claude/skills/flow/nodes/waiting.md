# Waiting or stopping

Before ending a turn, consider the following.

- Is anything left that I could do myself? Then it isn't a wait.
- What exactly am I waiting on: CI, a deploy, another PR, a
  person, a date? Who or what tells me it's over?
- Waiting on another ticket? Check its status, then `wt rb
  <ticket>`: I get told when it reaches prod.
- Waiting on something else that isn't Rasmus? Then `wt w8 <deadline>
  "<what>"`, so the wait has an end someone checks.
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
  minutes from an artifact (screenshots, the one or two decisions)?
