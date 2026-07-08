---
name: writing-code
description: "Baseline conventions for writing or editing code in any repo. Load before writing/editing source. Yields to repository-specific guidelines (CLAUDE.md, style configs, existing patterns) on any conflict."
---

# Writing Code

Baseline conventions. **Repository-specific guidelines always win** on
conflict — a repo's CLAUDE.md, style config (prettier, eslint,
editorconfig, rustfmt, …), or the patterns already in the file override
anything here. When unsure, match what the surrounding code does.

## Comments

- No explanatory comments. Correct code speaks for itself.
- Rationale — pitfalls avoided, non-obvious reasoning — goes in the
  commit message, not the source.
- Why: returning to a file, you follow the patterns already in it; the
  pattern is the guide, so a comment adds nothing.
- Exception: match a file's existing comment density. If a file
  deliberately documents (public API docblocks, license headers),
  follow suit.

## Follow established patterns

- Read the surrounding code first. Match its naming, structure, error
  handling, and idioms so new code is indistinguishable from what's
  there.
- Reuse existing utilities/helpers instead of writing new ones. Search
  before adding.

## Line length

- Wrap at 80 chars unless the repo's own style config says otherwise
  (then defer to it).
