---
name: dev-stack
description: Load before starting, using or stopping a worktree's local dev stack (`dev up`/`dev down`, penv, the be/fe/admin panes) or testing in the browser through chrome-devtools, local or on staging/production after a deploy — 'run the app', 'test it in the browser', 'check it in devtools', 'start the stack', 'dev up'. The stack is off by default; start it only to test, stop it when done, and never stop a stack you didn't start.
---

# Dev stack: off unless you're testing

Many sessions share this laptop. Each running stack (backend, frontend,
admin, node watchers) costs gigabytes of RAM. So the norm is: the stack
is **off**. Turn it on to test something, then turn it off.

## Before you start: is it already running?

```sh
dev ls | awk -v s="$(tmux display-message -p '#S')" 'NR==1 || $1==s'
```

- **Rows for this session:** someone else started it, usually jrb
  testing by hand. Use it as is. Don't restart it, and **never** `dev
  down` it.
- **No rows:** you start it, so you own it.

Remember which case you're in. Only the owner stops it.

## Test slots: at most 2 agents at once

Running a stack or driving the devtools browser takes a **test slot**
(`test-slot`, one per tmux session). Only 2 agent sessions hold one at
a time; past that the laptop swaps until the disk fills. jrb's own
stacks never take a slot and are never blocked.

- `dev up` takes the slot for you; `dev down` frees it. A devtools call
  takes it through a hook if one is free.
- **Busy** (`dev up` or the hook exits with `WAITING until HH:MM:SS`):
  don't give up and don't work around it. Tell the user plainly that
  you are waiting for a test slot and until when, then run `test-slot
  wait` with `run_in_background: true` and `timeout: 1500000`. When it
  exits 0 you hold the slot; carry on. When it exits 75 it printed the
  next wait (backoff doubles from 30s, capped at 20 minutes): say the
  new time and wait again. Keep working on other things meanwhile.
- **Done, pausing or blocked** (the moment you stop actively using the
  browser — including when you give up on it, hit a blocker you need
  the user to resolve, or pause for an AskUserQuestion / open-ended
  reply — not when the whole task ends): `dev down` if you started
  the stack, else `test-slot release`. "I'll need the browser again
  in a few minutes" is still a release — the slot is scarce and a
  user reply is open-ended. Reacquire with `dev up` when you resume;
  it's cheap. `test-slot release` quits your devtools Chrome (only
  yours); `dev down` stops the browser of every agent in the session.
  Either frees the slot once no agent in the session still claims
  it. Slots also free when your
  pane or session ends, or after 30 idle minutes with no stack up,
  but don't rely on that.
- `test-slot ls` shows who holds what.

## Start, test, stop

1. `dev up --wait` (takes the test slot). It rebuilds this session's
   `run` window and polls the URLs. Run it from the worktree you're
   testing, in the main session's own worktree. Never run it from an
   isolated subagent worktree (`.claude/worktrees/agent-*`): it would
   replace the parent session's `run` window with your checkout.
2. URLs and stage come from `penv info` (be, fe, admin ports). Logs:
   `.jrb/logs/<tag>.log`, or `dev logs <tag>`. Only services listed
   under `local:` run your branch; the fe calls every other service on
   the deployed stage. With `local:` empty, `dev up` starts no backend
   (an empty `SERVICE_LIST` used to start every service, workers
   included). On production, never `penv local add` anything unless
   jrb asked. Their logs are in CloudWatch, not
   `.jrb/logs`: read them yourself, without asking (read-only, any
   stage), via the repo's `cloudwatch-logs` skill
   (`run-cloudwatch-logs.js --staging --service synth ...`). To test backend changes, `penv local add <svc>`
   before `dev up`, and `penv local rm <svc>` when done.
3. Test. Batch your checks so the stack is up once, not toggled per
   check.
4. `dev down` as soon as you're done, if you started it; it frees the
   slot. Don't leave it idle while you write code, wait on an agent or
   report. Starting it again later is cheap; idle RAM isn't. A stack
   lives 10 minutes after `dev up`, then goes down on its own; a
   longer test asks for more up front (`dev up --for 30`) or extends
   (`dev keep 20`, minutes; `dev keep` alone = 10 more).

If a code change needs a restart, the be/fe watchers reload on their
own. Don't `dev up` again just for that. Never touch `node_modules`
(`yarn install`, `wt dedup`) under a running stack: it breaks the fe
build; park the devtools tab on `about:blank` until it's restarted.

## Browser testing (chrome-devtools MCP)

- Load the tools via ToolSearch (`mcp__chrome-devtools__*`).
- Open your own page with `new_page`; never drive a page another session
  opened.
- Point it at the local fe URL from `penv info`, not the deployed app.
- Login screen: load `polar-agent-login`.
- Handing a page to jrb (to log in, to look): many Chrome windows are
  open, so lead with the ports, then what each tab is, e.g.
  "`:3066` admin + `:3036` fe — devtools window for `<tmux session>`".
  Bring it to the front first (`select_page` with `bringToFront`).
- The stack talks to the stage `penv info` shows. On staging, writing
  through the app UI (create, edit, delete, restore) is fine without
  asking; use throwaway objects and delete them when done (e.g.
  Force MFA, `#tenant-setting-force-mfa` at `/<slug>/settings/users`:
  switch it back off). Never write
  to the staging database directly (SQL, insert/update scripts). On
  production, look only unless jrb asked. Never switch stage to
  production.
- Feature behind a flag you can't toggle: hardcode it on locally
  rather than toggling it in admin or writing to staging. Do it in
  every gate (frontend hook and the backend check, with that service
  in `penv local`), never commit it, and `git checkout --` it before
  `dev down`. List the gate files in the agent brief's owned files.
- Lifetime: the browser MCP and its Chrome start on your first devtools
  call. They stop on `dev down`, when the stack's slot expires (see
  step 4), or after 10 idle minutes when
  no stack is up (staging/production checks); freeing the test slot
  (see Test slots) also quits your Chrome. The first call after a stop
  takes a few seconds and starts from a fresh page: re-navigate and
  log in again (`polar-agent-login`).

### Who drives the browser

The visual pass is mechanical (click, screenshot, compare to a list), and
its cost is turns re-reading a big context: one hand-driven check ran
411 turns. Hand it to a fresh Haiku or Sonnet subagent; keep Opus for
choosing what to check and for judging what comes back.

- Brief it with a checklist: the URL, the steps, and per state what
  "right" looks like (layout, clipping, empty and error states, copy).
- It returns the screenshot paths and a verdict per checklist item, not
  a summary. A small model's "looks fine" proves nothing: the main
  agent opens the screenshots and makes the call, and they go in the
  artifact for jrb (see Show what you tested).
- Cap it (about 60 turns). Past that, stop and report where it got
  stuck rather than looping.
- Flow logic that a regression would break belongs in a spec (next
  section); the subagent covers what a spec can't judge.

## Turn repeat browser checks into tests

A devtools run proves the change once; a test proves it on every PR.
Before or after a devtools session, ask whether the check should live
on as a test, and pick the cheapest layer that covers it:

- **Logic, data shaping, a hook, a resolver** → unit or component test
  (jest / testing-library). Cheapest, no stack, no flake.
- **A user flow a regression would silently break** (navigate, edit,
  save, see the result) on seeded `techtests` fixtures → Cypress e2e,
  via the repo's `end-to-end-tests` skill. Extend the nearest existing
  spec before adding a new one.
- **Stay manual** for one-off or visual checks, anything that depends on
  one tenant's data, and backend-only changes: the PR e2e gate builds
  only the frontend and calls deployed staging, so it never runs the
  PR's backend; cover those with service tests.

Weigh the e2e cost before adding: every spec adds minutes to all 3 CI
shards, leans on the one small shared staging synth task, and is a new
flake source. A spec earns its place when the flow is user-critical and
has broken before, or would otherwise need a devtools re-check on every
change. Say in the PR which checks became tests and which stayed
manual, and why.

## Show what you tested

jrb should see the result without starting a stack. For any change a
user can see, screenshot each key state during the run, not after:
the before state, the action, the result, and any error message.

- `take_screenshot` with `filePath` set to
  `<worktree>/.jrb/screenshots/<nn>-<what>.png` (ignored by git).
  Crop to the relevant element (`uid`) when the page is busy.
- Publish one Artifact page with every screenshot in order, each with
  a one-line caption saying what it shows and what to look for. Add
  non-visual results (API or MCP responses) as short text blocks.
  Every image opens full size on click (a lightbox closed by click
  or Escape); thumbnails alone are too small to review.
- Give jrb the link in your report and put it in the PR's "How to
  test" section.

## Testing Polar MCP tools

- Call a tool with `polar-mcp-call <tool> '<json args>'` (no args
  lists tools). It goes through `polar-mcp`, so no `/mcp` reconnect
  and no key in your hands. Start with `get_context` for a
  `conversation_id`.
- Your branch's tool code runs only with `penv local add ai-service`
  before `dev up`.
- Auth is the env's `penv key`. On staging use
  `staging-food-and-beverage` (the agent user's workspace):
  `penv key staging-food-and-beverage`. `default` gets a 401 there.
- Ask Polar in the app runs on Hermes against the deployed
  ai-service, so it never tests your branch.

## Other heavy things you start

The same rule applies to anything else you spin up for a test, e.g. a
Docker container like the Hermes box clone (`scripts/hermes/
local-gateway.sh down`). Stop it when done, if you started it.
