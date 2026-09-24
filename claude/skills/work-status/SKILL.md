---
name: work-status
description: "Answer 'what are you working on?', 'status?', 'where are we?', 'what's in flight?' as a grouped board of open threads — landed, running, queued, dispatched, parked, and what needs my decision. Use when I ask for status, for a recap of what you're doing, what's still open, or where things stand. Inline only; never written to a file, PR, or ticket."
---

# Work status

A board of every open thread, grouped by who holds it and what
state it is in. Written for someone steering several threads at
once who has lost track of which are actually moving.

Terse. No preamble, no closing summary, no "hope this helps".

## Shape

Bold group heading, then numbered items. One line each: a bold
label of about five words, then one clause saying where it stands.
Number continuously across groups so I can say "do 4 first".

```
**Landed** — done and verified, sitting in the tree

1. **Short label** — one clause, and what verified it.

**Running** — in flight this moment

2. **Short label** — who holds it, what it returns.

**Mine, next** — queued, in the order I will do them

3. **Short label** — one clause.

**Dispatched to <name>** — held by another session

**Blocked on you** — stopped until you answer or look at
something, each as an actual question with options

**Blocked on something else** — stopped on a job, a deploy, a
person, a measurement; name it and say who can clear it

**Found along the way** — discoveries that are not tasks yet
```

Drop any group with nothing in it. Never pad a group to fill the
shape.

## Rules

- Never state a dispatched agent's result before its completion
  notification has arrived. It is **Running**, with what it will
  return — not a predicted outcome. Predicting one is fabrication.
- **Landed** means verified, and the item says what verified it
  (tests green, tsc clean, traced in code). Written-but-unchecked
  is **Running**, never Landed.
- Distinguish in-the-tree, committed, and pushed. They are three
  different states and I will act on them differently.
- Always render both blocked groups, even when empty — "Nothing
  blocked on you" is information I act on. Never quietly omit them.
- A blocker names what would clear it and who can clear it. "Awaiting
  input" is not a blocker; "needs your eyes on the total row in a
  browser, jsdom cannot see grid placement" is.
- Never sit on a blocker until I ask for status. Surface it the
  moment it appears, especially before I step away.
- Do not invent a decision to fill the section. If nothing is
  blocked, say so in one line.
- Drop items whose evidence has already closed them, and say once
  that they are dropped and why. Carrying a settled item as "open"
  is worse than not listing it.
- If the status corrects something stated earlier, correct it in one
  clause and move on. No re-litigating, no apology paragraph.
- Anything not verified this session is labelled as unverified, in
  the item, in plain words. No "should be" or "probably".
- Wrap at 80 characters.
