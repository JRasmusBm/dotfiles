---
name: iterate
description: "Work a queue autonomously, one chunk at a time, until everything left is blocked or done — 'iterate on this', 'keep iterating', 'keep going', 'work through this', 'work autonomously', 'don't stop to ask', and the away variants 'iterate until I'm back', 'keep going while I'm gone', 'I'll check later'. Sets a self-paced wakeup loop, reports with the work-status skill each tick, and moves judgement calls into blocked rather than guessing."
---

# Iterate

Work the queue without waiting on me between items, and stop
cleanly rather than guessing past a decision.

This is about who holds execution, not about whether I am here. The
loop runs the same while I am watching: it keeps you driving the
work so I can stay on the vision and the result. Do not wind it
down because I started talking, and do not treat my presence as an
invitation to hand decisions back that you could make yourself.

Each tick is a fresh turn: work a chunk, report, schedule the next.
The loop restarts you, it does not make you faster. Say so if I seem
to expect otherwise.

Reporting is not this skill's job — it delegates. Load the
`work-status` skill at every tick and answer in its shape, including
its two blocked groups. Do not improvise a status format here; if
that skill is missing, say so rather than inventing one.

## The queue folder

Keep the queue on disk, not only in the conversation — a compaction
or a killed session takes the conversation but not the files. Write
it before the first tick and rewrite it at every tick.

Start as a folder. Not a file that grows into one: one file per
task from the outset, plus an `INDEX.md` of one line per task
linking to it. Waiting until it outgrows a screen is too late — by
then you are rewriting one long file every tick, and the detail that
makes an item resumable has been squeezed out to keep it readable.

The index carries the states as headings — in flight, mine next,
blocked on you, blocked on something else, superseded, landed — with
one line per task underneath and nothing else. Landed work stops
being a task, so it collapses to a one-line entry with its commit
sha and no file of its own.

A task's file holds what the index cannot: the trace with paths and
line numbers, the options and which one I picked, what was tried and
reverted and why, what is still unproven. Name them `NN-slug.md` so
the index links read as prose. An item that turns out to be wrong
gets a superseded state and a pointer to what replaced it, never a
deletion — the reasoning is the part worth keeping.

Put it where I can open it: a gitignored path in the repo beats the
scratchpad. A `temp_queue/` folder in the working tree is ignored by
my global `~/.ignore`. Prove that with `git check-ignore -v <path>`
before writing there, never assume it — other sessions run
`git add -A` and an unignored file gets swept into their commit.

At the start of every tick, read the index first and trust it over
memory. Open a task's file only when you work that task.

**Whoever works a task updates its file before it is done** — the
state line, what landed, what moved underneath it. Put that in every
agent brief as part of its definition of done, not as an
afterthought. Otherwise an agent hands back a finished change and
leaves the file describing a tree from two commits ago, which is
worse than no file, because the next tick will trust it.

That rule has a hole, and it is the one that actually bites: the
commit happens after the worker is gone. An agent truthfully writes
"done, not committed", you commit later, and nobody goes back for the
sha. So **the committer owns the state line** — writing the sha into
the file is part of committing, the same action, not a tidy-up
afterwards. Files still claiming "not committed" about work that
shipped is the commonest way this whole scheme rots, and it rots
silently, because every one of those lines was true when written.

One state line per file, on line 3, nowhere else. A second one
further down under "what landed" drifts out of step with the first,
and a file that contradicts itself is worse than one with no state
at all.

You and the agent both want that file, so split it by the clock: a
task's file belongs to the agent working it, for as long as it runs,
and goes in its owned list like any source file. The index is never
an agent's — that one is always yours, and it is where you record
anything you notice about a task while its file is out on loan. When
the agent hands back, the file is yours again, and the sha goes in
then. Two writers on one file is how a queue loses the only record
of why something was tried and reverted.

## The loop

1. Schedule the next tick with `ScheduleWakeup`. Carry the whole
   queue in the `prompt` — the next firing continues from that text,
   not from memory.
2. Work items in the order I set, one or more per tick.
3. Reconcile before reporting, every tick, no exceptions: grep every
   task file's state line, compare it with the index, and let the
   tree break any tie — check the sha, not the prose. Fix what
   drifted. A board reported off an unreconciled queue is a board
   reported from memory, and it will be confidently wrong.
4. End every tick by invoking the `work-status` skill and giving
   its board. That board is the tick's output — the queue state
   lives there, not in prose.
5. Reschedule with the queue rewritten: items done, items newly
   blocked, items discovered.
6. Stop with `stop: true` only when every remaining item is either
   blocked or done — nothing left that you could move on alone. Say
   which of the two ended it.

## Delegate the building, keep the judgement

Send the work out and keep the deciding. The point is that talking
to me never waits on building: a subagent runs in the background,
so I can ask a question, change my mind or add a task and get an
answer straight away instead of watching you edit files. It keeps
your own context on the queue too, but that is the lesser reason.

- **Delegate** anything multi-file, anything long, anything whose
  output you would otherwise read in full: a feature from a settled
  spec, a mechanical change across call sites, a sweep for where
  something lives. Write the brief so nothing is left open — name
  the files, the semantics, the verification commands — and give it
  an owned-file list that is disjoint from every other agent in
  flight, because they share the tree. Say whether that list is a
  hard boundary or only collision avoidance, and say what to do when
  the task cannot be done inside it: stop and report, never widen it
  quietly. An agent told only which file to avoid will treat every
  other file as fair game.
- **Do inline** what costs less to make than to describe: a
  one-line fix, a rename, a lint error, an edit you already have
  the exact text for. Delegating those is slower and buys nothing.
- **Never delegate the decision.** An agent reports; you adjudicate.
  Ask for received output verbatim rather than a summary, and do
  not let it tune expectations or code to close a gap — that is
  yours to rule on.
- Verify what comes back. Agents have reported clean while lint was
  failing, and have been right about a contract while wrong about
  the call site.

## What you may decide, and what you may not

Execute decided work. Queue judgement calls.

- **Decide freely** — anything mechanical, anything I already chose,
  anything with one obviously right answer: naming, dead code, a
  failing lint, the order of two independent edits, a test that
  pins behaviour we agreed on.
- **Move to blocked instead** — a design choice I have not made, a
  trade-off with real cost both ways, a change to a shape I would
  want to see first, anything needing a browser, a measurement, or
  an answer from a person.

Moving an item into blocked is a success, not a failure. You are
explicitly allowed to reclassify anything as blocked at any tick. A
blocked item with a crisp question beats a built item I never asked
for.

## Rules

- Never guess past a decision to keep the queue moving. The queue
  finishing is not the goal; the queue being right is.
- Unsupervised turns compound — nobody catches an over-correction
  for an hour. Prefer the smaller, reversible edit, and prefer
  stopping to improvising.
- Verify before calling anything done, and say what verified it.
  Unverifiable items are built and flagged, never quietly claimed.
- Commit at every coherent point and leave the tree clean. A tick
  that ends green — tests, typecheck and lint — and leaves work
  uncommitted has not finished. Do not save it all up for my return.
- Never `git add -A` or `git add .`. Name every path. Other sessions
  and agents share this worktree and their half-finished files will
  be swept into my commit otherwise; that has already happened once.
- Never commit a tree that does not build. If a subagent is still
  editing files the commit would span, wait for it and say why.
- Push only if I asked. Committing is not pushing.
- Check CodeRabbit and CI for review comments at the status check,
  and again before pushing — never while a run is in flight, since a
  push restarts it and wastes the review. Fold anything found into
  the board as its own item rather than fixing it silently.
- Do not start work that is not on the queue. Discoveries go under
  **Found along the way** on the board, not into the tree.
- A tick that produced nothing says so and is marked a no-op. Never
  invent progress to fill a tick.
- Lead every board with what is blocked and what needs me, not with
  what got done. That holds whether I have been away or watching.
- A blocker goes to me the moment it appears, not at the next tick.
  Ticks pace the work; they do not pace the questions.
- A task I give you mid-loop joins the queue. Add it, say where it
  landed and why, and keep going — do not stop the loop to ask
  where it belongs, and do not silently jump it to the front unless
  it blocks something already in flight.
- If I interrupt with a question, answer it and carry on. The loop
  survives a conversation; only `stop: true` ends it.
