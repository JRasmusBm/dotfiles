---
name: dev-stack
description: Load before starting, using or stopping a worktree's local dev stack (`dev up`/`dev down`, penv, the be/fe/admin panes) or testing in the browser through chrome-devtools — 'run the app', 'test it in the browser', 'check it in devtools', 'start the stack', 'dev up'. The stack is off by default; start it only to test, stop it when done, and never stop a stack you didn't start.
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
- **Done:** `dev down` if you started the stack, else `test-slot
  release`. Either one quits your devtools Chrome (only yours, other
  agents in this session keep theirs) and frees the slot once no agent
  in the session still claims it. Slots also free when your pane or
  session ends, or after 30 idle minutes with no stack up, but don't
  rely on that.
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
   the deployed stage. Their logs are in CloudWatch, not
   `.jrb/logs`: read them yourself, without asking (read-only, any
   stage), via the repo's `cloudwatch-logs` skill
   (`run-cloudwatch-logs.js --staging --service synth ...`). To test backend changes, `penv local add <svc>`
   before `dev up`, and `penv local rm <svc>` when done.
3. Test. Batch your checks so the stack is up once, not toggled per
   check.
4. `dev down` as soon as you're done, if you started it; it frees the
   slot. Don't leave it idle while you write code, wait on an agent or
   report. Starting it again later is cheap; idle RAM isn't.

If a code change needs a restart, the be/fe watchers reload on their
own. Don't `dev up` again just for that.

## Browser testing (chrome-devtools MCP)

- Load the tools via ToolSearch (`mcp__chrome-devtools__*`).
- Open your own page with `new_page`; never drive a page another session
  opened.
- Point it at the local fe URL from `penv info`, not the deployed app.
- Login screen: load `polar-agent-login`.
- The stack talks to the stage `penv info` shows. On staging, writing
  through the app UI (create, edit, delete, restore) is fine without
  asking; use throwaway objects and delete them when done. Never write
  to the staging database directly (SQL, insert/update scripts). On
  production, look only unless jrb asked. Never switch stage to
  production.
- When done, free the slot (see Test slots); that quits your Chrome.

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
