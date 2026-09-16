---
name: what-changed
description: "Answer 'what did you change?' or 'what will change?' inline, as test-suite-style scenarios with before/after behaviour and code links. Use when I ask what changed, what did you change, what will change, what are you about to change, summarise your changes, or walk me through the change or plan. Never written to a PR body, file, or comment."
---

# What changed / what will change

Answer inline, in this session, for someone who designed the change
with you but hasn't read the code. Terse. A one-file fix is one
scenario; a multi-package change is five or six.

Two modes, same shape:

- **Changed** (work done): `before` and `after` are both traced in
  code, on dev and on this branch.
- **Will change** (plan agreed, nothing written yet): `before` is
  traced on the current tree; `after` is the planned observable
  behaviour; `why` names the existing code the change lands in, with
  path:line. Head the answer `**Planned:**` instead of `**Fix:**` and
  end with `**Tests:**` listing the scenarios that will get one.

## Shape

```
**Fix:** one line, the bug or feature in user terms.

**<Scenario as an it() name: concrete actor, action, condition>**
- before: what was observed
- after: what is observed now
- why: mechanism, with `symbol` (path:line) for each hop that
  matters

**Verified:** test files or commands that cover the scenarios above;
name any scenario with no test.
```

Scenarios are what a person or client does and sees, not code
paths. Code appears only under `why`. Reference form: full
project-relative path with line the first time a file appears, then
`filename:line`. Avoid single-letter variables; write `<sectionId>`.

## Rules

- Trace `before` in the code, always. In changed mode trace `after`
  too, on this branch. Never derive either from the plan, the PR
  text, or memory of what you intended. If a line was not traced,
  write `untraced` on it instead of a guess.
- In will-change mode, an `after` that the plan leaves undecided is
  written `open:` with the options, not resolved silently.
- Read the file before citing a line; the symbol must be on it.
- One line per bullet where possible. No extra prose, no headers
  beyond the bold scenario names, no summary at the end.
- Output stays in the conversation. Do not add it to the PR body,
  a doc, a commit, or a Linear comment unless explicitly asked.
