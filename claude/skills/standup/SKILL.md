---
name: standup
description: "Survey my Linear tickets, wt worktrees and PRs into a standup board: what moved since yesterday, and what's stale. Use for '/standup', 'standup', 'what's my status', 'survey my tickets and worktrees', 'what am I working on' (my work, not this session's threads — that's work-status). Inline only."
---

# Standup

A board of all my work in the current repo, split by whether
anything touched it since the previous workday.

## Gather

1. Linear `list_issues` with `assignee: "me"`, `limit: 250`,
   `fields: [id, title, status, priority, project, updatedAt,
   assignee]`. It can't filter to open issues, so closed ones
   use up the page. While `hasNextPage` is true, fetch again
   with `cursor`. A large page gets saved to a file, so note its
   path. Save a page that comes back inline to the scratchpad
   yourself.
2. Unassigned work in my teams: `get_user me` lists the teams.
   For each one, run `list_issues` with `assignee: "null"`,
   `state: "started"`, `team: <name>` and the same fields and
   paging. `started` covers In Progress, Owner review, Needs
   live verification, Ready to deploy and Blocked.
3. `~/.claude/skills/standup/collect --linear <page>...
   --linear <page>...`, one `--linear` per query from steps 1
   and 2, with its pages in order. It refuses to run if any
   query's last page has `hasNextPage`. It prints TSV:
   `fresh|stale  section  branch  ticket  pr  date  source
   status  priority  title`. There's one row per board entry,
   per on-disk ORPHAN worktree, per OPEN PR OFF BOARD, per
   branch `wt rm`'d since the cutoff (REMOVED, closed tickets
   included), and per LINEAR ONLY open issue that has no branch
   (UNASSIGNED when nobody is assigned). The script maps
   old ticket IDs from before team moves (`pol-1921` →
   EXP-48) by title slug. `source` names the latest activity
   (`commit`, `claude` session, `pr`, `linear`, `removed`).
   Claude activity comes from the `gitBranch` and `timestamp`
   on each transcript line, not file mtimes or worktree paths,
   so it survives `wt rm` and mid-session branch switches. A
   row is fresh if that activity or the issue's `updatedAt`
   falls after the `# since` cutoff (the previous workday,
   00:00; Monday looks back to Friday).

If a branch row has an ID but no status, its ticket is closed
or wasn't matched. Resolve it with `get_issue <id>` if it
matters for the board; never guess.

## Shape

Two top sections, `**Updated since <weekday>**` and
`**Stale**`. Each has these subsections, in this order, with
empty ones skipped:

- **Needs action**: mismatches. Merged PR but the ticket isn't
  Needs live verification/Done, or the entry is still on
  speed-dial or IN PROGRESS. Ticket in review but its PR is
  closed. Ready to deploy. Merged/closed board sections that
  `wt clean` would clear (collapse them to a count).
- **Wrapped up**: REMOVED rows, fresh only. Merged + removed
  work from the last workday, so it isn't missing from Monday's
  board. A REMOVED row whose ticket is still open and not
  Needs live verification goes under Needs action instead.
- **Owner review, PR open**
- **In progress, no PR**
- **Needs live verification**
- **Worktree started, ticket still Backlog/Todo**
- **No ticket**: board branches with no issue.
- **Off the board**: open PRs and orphan worktrees not on the
  board.
- **Unassigned in my teams**: UNASSIGNED rows. A branch row
  whose ticket has no assignee also gets flagged in its own
  subsection.
- **Todo / Blocked**
- **Backlog**: count only, grouped by project, plus any High
  or Urgent items by ID.
- **Paused**: one line.

One item per line, never several IDs merged into one line:
`- **<title>** · what's off · #PR · ID`. Lead with the title,
because I recognise work by what it is, not by its ID. The
title is the ticket title from the TSV, shortened to about 45
characters and rephrased plainly if the original is garbled.
The ID goes last, for lookup only. A branch with no ticket uses
a plain description from its name and commit subject. Mark
High or Urgent priority with a leading `‼`. Put the date on stale items so their age shows.
The only exceptions are the collapsed DONE rows and the
Backlog/Paused counts. End with unresolved questions only, e.g. a closed PR
that might have been superseded. Don't change tickets or the
board; offer it as a question.
