---
name: catch-up
description: Back in a parked worktree, catch up on what happened while it was parked and act on it — '/catch-up', 'catch up', 'what happened while I was away', 'I'm back', and whenever a prompt says wt-tell held tells for this worktree. Reads the held tells (wt-held), the PR, deploys, artifacts and the ticket, reports in a few lines, then does the held work.
---

# Catch up on a parked worktree

While a worktree is parked, `wt-tell` holds tells that can wait
(a staging deploy, red CI, a stale PR) instead of waking its agent:
each wake re-reads the whole chat. This is where they land. One
pass now replaces the many wakes they would have cost.

1. `wt-held list`: what was held, oldest first, with its age. Later
   facts supersede earlier ones (a production deploy makes the
   staging one moot; a newer CI run replaces an older failure), so
   check each against now, not as it was.
2. Read the current state the held rows point at, and whatever else
   moved without a tell: the PR (state, checks, review threads),
   where it is deployed (the repo's deploy skill, if any), the
   ticket's status and comments, artifacts this worktree published.
3. Report in a few lines: what changed, what is moot, what you will
   do. Then do it, as the original tell asked (fix CI, verify the
   deploy, answer the reviewer, …).
4. `wt-held done` once handed over, so the next prompt stops
   mentioning them.

If my message asks for something else first, do that first, then
catch up. Nothing held and nothing moved: say so in one line.
