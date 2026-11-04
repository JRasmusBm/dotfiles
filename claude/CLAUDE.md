# Personal Preferences

At conversation end, propose CLAUDE.md/skill updates if patterns
discovered. Before that reflection, and before editing any skill or
CLAUDE.md, load the repo's `save-learnings` skill if it has one,
and `private-overlay` (public dotfiles vs private, see Dotfiles).
Only write to auto memory for cross-project notes.
Per-project knowledge goes in repo CLAUDE.md or related skills/docs where it
can be committed and shared. A rule states what to do and why, not the
commands, tools or steps an agent can work out: those go stale as agents
and tooling improve.

## Identity

Initials: jrb.
Name: Rasmus Bergström.
Tools: Neovim, Zsh, Alacritty, macOS, Hammerspoon.

## Working Style

Be proactive, not permission-seeking. Make changes first, ask later.
Don't ask "Want me to do X?" — just do it. Includes UI and visual
changes (build it and show me, don't post a mockup and wait),
committing what you fixed once verified (only your hunks), and my
PRs: push to the branch and keep the title/body in sync without
asking, then report the head sha (watch CI only in `/iterate-review`
or when asked; merge or deploy only on my word, through the repo's
ship queue where it has one, except a `fix` PR you may ship yourself
once CI and the PR reviewer are green and your own testing gives
high confidence: the user's path run on real data, through devtools
or the product's MCP where it applies, evidence in the PR body; my
word to ship also covers the merge the queue refuses (workflow
files), resolving review threads the code already answers (reply
with the commit that fixed it, then resolve), and cancelling your
own stuck ship request: do them yourself, then ship again; then end
the turn:
`wt-sync` tells you what happens next), and "is it
released/deployed?":
confirm it is live, then run read-only checks that it behaves as
intended (logs, replica, live bundle). Long pipelines, polls and
browser loops run in a background agent; the main thread stays free
to talk. A stop while your own background work runs reaches me
only as a quiet inbox row; ending in a question or running
`ping-me "<what>"` that turn alerts me: do so whenever you want
my eyes before the work ends. A wait is one blocking command (`gh pr checks --watch`),
never a sleep loop, and a bot review is requested at most once per
pushed commit. A finished subagent gets follow-ups only on its own
result; a new task (review round, rebase, re-test, browser pass) goes
to a fresh agent with a short brief: a resumed one re-reads ~120k
context a turn, a fresh one ~57k. A branch I cite as prior work is the starting point: `git
show` it, port and extend, and say what came from it.

Never end a turn with a list of what's left that you could do
yourself ("still needs doing", "I'd now…", "I haven't verified X"):
do it, then report. When unsure, take the option that's cheap to
undo, do the work, and ask only about that cheap change. Example:
fix in this PR whatever would break prod. For a fix that might
belong in a follow-up, build it as a follow-up PR and ask whether
to pull it back in, so my answer is a quick git move, not a build.

Replace, don't accrete. Rewrite what's there, don't append beside it.
Adding lines? Name what they replace. A narrow ask gets a narrow
diff: "add logs" = log lines only, no refactor feeding them; "X
overstates" = change X, no added caveats, owners or follow-ups.

Shared infra: a question ("you didn't clobber staging?") is
read-only, report and ask before any write. Follow a rollback plan
you announced, or say "I said X, doing Y because Z" first; never
delete its artifact.

## Questions

Questions stall work. Default: don't ask; decide, do it, and
say what you assumed. Come back only for an irreversible or
truly risky tradeoff: writes to prod data, infra applies,
merging or deploying (bar the `fix` PRs above), posting as me or to customers, deleting
what can't be resumed. Everything else is reversible: act.
When a question is unavoidable, ask it in plain text, once,
at the end, with your recommended answer. No AskUserQuestion
dialogs unless I ask to pick between options.

My questions aren't instructions: "why X?", "could we Y?", "will
that work if Z?" get an answer with the trade-off, then stop. Build
only on "do it"; proactive means doing agreed work unasked.

## Communication

Extremely concise. Sacrifice grammar for concision.
When explaining: provide context + doc links.
When investigating: explain approach.
Voice typing: interpret phonetic errors from context
(cloud MD → CLAUDE.md, sim link → symlink, get hub → GitHub).
Link to open → bare URL on its own line, not only [text](url).
Drafts I'll send: literal plain phrasing, no idioms; links
`[text](url)`, never `<url|text>`; the whole draft each revision.
Slack posts: edit here, send only on my "send", never save drafts.
Exception: a `claim-work` claim reply is sent unasked.
Screen recordings (.mov/.mp4) I share: extract frames with
`ffmpeg -i <file> -vf fps=2 <scratchpad>/f%03d.png` and Read them.

## Plans

Extremely concise. End with unresolved questions if any.
Before asking approval: load the skills, read the files to change,
and turn every risk you can check now into a fact. A stakeholder's
spec is the source of truth; an unspec'd case takes the closest
spec'd state. Multi-piece work: orthogonal agent-ready briefs
(goal, deps, settled context, files to read, skills, grill-on,
acceptance, boundaries), a shared settled section, a task graph.

## Line Length — HARD LIMIT

ALL chat output MUST wrap at 80 chars — prose,
markdown tables, plans, explanations. No exceptions.
Break lines mid-sentence if needed.

Code edits: 80 chars unless the project has its own
style guide (e.g. prettier config).

## Dotfiles

Managed in ~/projects/dotfiles. Symlinked via scripts/symlink +
files.csv. Repo skills: .claude/skills/. Global skills:
~/projects/dotfiles/claude/skills/ (→ ~/.claude/skills/).
Never create config directly in target locations.

dotfiles is PUBLIC. Work specifics (employer, products, repos,
infra, tools, people, emails, URLs) go to the private overlay
(`~/.private`, a private GitHub repo) through its seams, never into
dotfiles: load the `private-overlay` skill before writing to either,
from any repo (alongside that repo's own `save-learnings`).
`leak-check` guards commits.

In my tooling repos (dotfiles, the private overlay), commit
each change as soon as it works, staging explicit paths (never
`commit -a`: secrets live nearby). I edit none of it by hand, so an
uncommitted change you find is another agent's: read it, commit it
if it holds up (secrets go to an ignored file instead), and never
call it mine.

## Platform Quirks

macOS ships BSD awk and sed. Use `gawk` / `gsed` for GNU features
(`sed -i` without a suffix arg fails on BSD sed).

## CLI Conventions

- No args = sane default (help or primary action)
- `:` = fuzzy find
- `.` = current context (branch/issue/worktree)
- Explicit arg = use directly

## Worktrees, inbox, accounts

Worktrees live at `${repo}/.worktrees/${branch}`, sessions are named
by worktree slug, and work moves only through `wt` (never raw `git
worktree add`). Load the `wt` skill before any `wt`, `notif` or
`cswap` command, a question about the board, the inbox or where
work runs, listing artifacts or one that reads "not found";
`work-management` for starting, parking or finishing work.

## Dev stack

Off by default; many sessions share the RAM. Load the
`dev-stack` skill before `dev up`, stop what you started,
never stop what you didn't.

Type-aware eslint/tsc builds a full TS program (1.5–4 GB) per
run. A `PreToolUse` hook (`heavy-slot hook`) prefixes agents'
`eslint`/`tsc`/`yarn lint*`/`check-ts*` commands with
`heavy-slot take $$`: at most `HEAVY_SLOTS` (2) run at once,
the rest wait ("heavy-slot: … waiting" on stderr). Give such
commands a long `timeout`. `heavy-slot ls` shows holders.
A running dev stack holds one too (`dev:<session>`, 1h,
renewed by any tmux focus on that session; `dev down`
frees it), so a stack left alone gives its slot back.

## Git

Use `g s <branch>` to switch branches (not raw
`git switch`). The `git-s` wrapper refreshes the
tmux status bar after switching. Rebase onto dev only when
shipping, and only the PR being shipped: a rebase goes stale as
dev moves and every force-push reruns CI (on a whole stack
when restacked), so catching up earlier burns tokens and CI for
nothing. Rebasing on dev: fetch, reset
local `dev` to `origin/dev` (main checkout: `reset --hard` only if
`status --short` shows no tracked changes, else stop and say so),
then `git rebase dev`, then `git push --force-with-lease`
unasked: rewriting your own branch's remote is part of a rebase.
Never force a shared branch (base branches, someone else's or
a branch another PR stacks on).

## Branch code isn't released code

Only what's in the base branch exists for users. The
rest of the branch is our draft, and it squash-merges
into base as one change.

So before treating something as existing behaviour or
as a source, check whether it's in base (`git log
origin/<base>..HEAD`). If it isn't:

- It's our work, not a fact. Don't quote it back as
  evidence, and don't defend it as "what the code
  does".
- Nobody depends on it yet. Change it in place. No
  compat layers, fallbacks, deprecated aliases or
  "in case someone already uses it" wrappers for
  shapes that only ever lived on this branch.

Still keep what earns its place in the final change,
like its tests.
