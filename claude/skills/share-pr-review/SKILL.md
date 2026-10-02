---
name: share-pr-review
description: "Build a PR review together in temp-review.md, then post it as one GitHub review batch and hand back a 'here are my review comments' message with links. Use for '/share-pr-review', 'share the review', 'let's write up the review', 'turn these findings into PR comments', and for 'publish the review' / 'post the review' once the doc exists."
---

# Share PR review

Three phases: draft the doc, iterate on it with me, publish on my say-so.
Nothing reaches GitHub before I say publish.

## 1. Draft `temp-review.md`

Resolve the PR: an explicit arg (number/URL), else `gh pr view` for the
current branch. Write the doc at the worktree root and keep it out of
git:

```sh
f="$(git rev-parse --show-toplevel)/temp-review.md"
x="$(git rev-parse --git-common-dir)/info/exclude"
grep -qx 'temp-review.md' "$x" || echo 'temp-review.md' >> "$x"
```

If the doc already exists, it's a draft in progress: read it and carry
on from phase 2 instead of overwriting it.

Seed it from the findings already in this conversation. If there are
none, review first (the repo's review skill if it has one, else
`code-review`), then seed. One section per finding, most severe first.

```markdown
# Review: <PR title> (#<n>)

PR: <url>
Verdict: comment

## Summary

<optional top-level review body; leave empty for none>

## 1. <one-liner>

- Severity: must-fix
- Share: yes
- Location: path/to/file.ts:42

<message>
```

- `Verdict`: `comment` | `request-changes` | `approve`. Default
  `comment`. On my own PR only `comment` works.
- `Severity`: `must-fix` | `should-fix` | `consider` | `question`.
- `Share`: `yes` | `no`. Default `yes`. Already raised by another
  reviewer on the PR: `no`, and say so in the message.
- `Location`: `path:line` or `path:start-end`, right side, as on the PR
  head, and **on a line in the PR diff**: every shared finding becomes
  its own inline comment, so the final message can link each one. If
  the code at fault isn't in the diff, anchor on the nearest diff line
  it affects and name the real location in the message. Read the file
  at that line before writing it.
- One-liner: the claim alone, at most ~60 chars. It becomes the link
  text in the final message.
- Message: written to the PR author, not to me. What's wrong, the
  concrete failure (input → wrong outcome), what to do instead. Plain
  literal words, no idioms, no hedges. Evidence inline (numbers,
  commands, links). Use a ```` ```suggestion ```` block only when the
  fix is an exact replacement of the commented lines. If I'm shipping
  the fixes in a PR of my own, say so in the Summary, not per comment;
  no links to the fixing lines.
- Summary: short. Never a second copy of the findings; the comments
  hold those. With a fix PR: "all the issues are fixed in #N if you'd
  like to use it".

After writing, print only the index: `N. [severity] [share] one-liner`
plus the path to the doc.

## 2. Iterate

I edit the doc in my editor as well as asking you to. Re-read it before
every change; never write from memory of an older version. Apply what I
ask, then reprint the index. Don't publish, don't ask "ready to
publish?".

## 3. Publish (only when I say publish / post / ship the review)

1. Re-read the doc. Build `payload.json` in the scratchpad from the
   `Share: yes` sections only:

   ```json
   {
     "event": "COMMENT",
     "body": "<Summary section, may be empty>",
     "items": [
       {"summary": "<one-liner>", "path": "a/b.tf", "line": 42,
        "start_line": 40,
        "body": "**Must fix:** <message>"}
     ]
   }
   ```

   Unwrap the doc's hard-wrapped lines: GitHub renders every newline
   in a comment as a line break, so join paragraph and bullet
   continuation lines; keep blank lines, list items and code blocks.

   `event`: `COMMENT` | `REQUEST_CHANGES` | `APPROVE`. Prefix each
   body with its severity label (`**Must fix:**`, `**Should fix:**`,
   `**Consider:**`, `**Question:**`). `start_line` only for ranges.

2. Run `~/.claude/skills/share-pr-review/publish <pr> payload.json`.
   It refuses (posting nothing) if any item's line isn't in the PR
   diff, since GitHub rejects the whole batch for one bad line:
   re-anchor those on a diff line and run it again. It posts one
   review, links each item to its own comment, and fails loudly if it
   can't find one. If it fails any other way, show me the error; don't
   retry with a changed payload without telling me what changed.

3. Relay its output verbatim: one `[one-liner](comment link)` bullet
   per shared finding, every link a `#discussion_r…` comment, never the
   review itself.

   ```
   I reviewed the PR, here are my review comments:

   - [one-liner](link-to-comment)
   ```

   If I'm also posting to Slack, write links the same `[text](link)`
   way, never `<url|text>`.

4. Delete `temp-review.md`. The PR now holds the review.
