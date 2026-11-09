---
name: repa
description: Republish an artifact under the active Claude login — '/repa', 'republish the artifact under the current user', 'the artifact link says not found', 'I can't open that artifact', 'move the artifact to this account'. After a cswap login change, links published by the other login read "not found" to this session; this puts a fresh copy on the active login and switches the work over to it.
---

# /repa — republish an artifact on the active login

A session sees only its active login's artifacts (see `wt` skill,
Claude accounts). After a swap, the old link can't be read or updated
from here, so the fix is a new copy, never a share request.

## Find the page

`artifacts` (this dir) / `artifacts <query>` lists every publish from
the ledger with its login and source file; an argument to `/repa` is
that query. No row means nothing was ever published: say so plainly
and don't invent one (if the work owed an artifact, building it is
the real task).

## Get its source

1. The ledger's file column, if it still exists (scratchpads under
   `/private/tmp` get cleaned).
2. Otherwise rebuild it from the session transcript that published it
   (`~/.claude/projects/<escaped cwd>/*.jsonl`, subagents included):
   the last `Write` to that path plus the `Edit`s after it. Write the
   result into this session's scratchpad.
3. Neither: say the source is gone and what it would take to rebuild.

Read the whole page before publishing, as for any file you didn't
just write.

## Publish and switch over

- Publish with no `url` (a new artifact on this login), same title,
  same supporting `files`. Uploaded assets and an artifact database
  don't travel: re-upload the assets, and say if db rows were lost.
- Replace the old link wherever it was handed out (PR body, ticket
  comment), and from then on update only the new copy.
- Report the new URL with its login; `artifacts` marks the old one
  `stale`.
