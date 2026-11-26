---
name: repa
description: Republish an artifact under the active Claude login — '/repa', 'republish the artifact under the current user', 'the artifact link says not found', 'I can't open that artifact', 'move the artifact to this account'. After a cswap login change, links published by the other login read "not found" to this session; this puts a fresh copy on the active login and switches the work over to it.
---

# /repa — republish an artifact on the active login

A session sees only its active login's artifacts (see `wt` skill,
Claude accounts). After a swap, the old link can't be read or updated
from here, so the fix is a new copy, never a share request. A
"Stopped watching … (artifact not found)" notice alone is no reason to
run this: see `wt`, Claude accounts.

## Check the active login first

Read it (`cswap list`, the `(active)` row) before anything else, and
again after every swap notice: the session's own context email and the
ledger lag behind it. Report it by name. On a borrowed login
(`~/.config/borrowed-logins`) Rasmus can't open claude.ai links, so
the copy he needs is local: publish the page through Artifact as
usual, the `artifact-local.sh` hook opens it in his browser and logs
its `file://` path, and that path is the link you hand back. Don't
wait to be asked: a swap onto a borrowed login mid-task means the
local copy, unprompted.

## Find the page

`artifacts` / `artifacts <query>` (on PATH) lists every publish from
the ledger with its login and source file; an argument to `/repa` is
that query. No row means nothing was ever published: say so plainly
and don't invent one (if the work owed a page, build it locally:
flow skill, artifacts node).

## Get its source

1. The ledger's file column, if it still exists (scratchpads under
   `/private/tmp` get cleaned).
2. Otherwise rebuild it from the session transcript that published it
   (`~/.claude/projects/<escaped cwd>/*.jsonl`, subagents included;
   `.jsonl.gz` once a month old: `gzip -cd`, images there are blanked):
   the last `Write` to that path plus the `Edit`s after it. Write the
   result into this session's scratchpad.
3. Neither: say the source is gone and what it would take to rebuild.

Read the whole page before publishing, as for any file you didn't
just write.

## Publish and switch over

- Does this login already hold a copy (`artifacts` lists one under
  it)? Then publish to that copy's `url` and bring it up to date: a
  swap back and forth should not leave one more copy per swap.
- Otherwise publish with no `url` (a new artifact on this login, or
  the local copy on a borrowed one), same title,
  same supporting `files`. Uploaded assets and an artifact database
  don't travel: re-upload the assets, and say if db rows were lost.
- Replace the old link wherever it was handed out (PR body, ticket
  comment), and from then on update only the new copy.
- Report the new URL (or `file://` path) with its login; `artifacts` marks the old one
  `stale`.
