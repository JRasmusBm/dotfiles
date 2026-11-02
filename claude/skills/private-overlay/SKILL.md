---
name: private-overlay
description: Where a learning, rule, script or skill goes when it touches my personal tooling — public dotfiles or the private overlay (~/.private). MUST load before editing any skill, CLAUDE.md, bin/ script or setting in dotfiles or the overlay, before the end-of-conversation reflection, and whenever work in another repo (a work repo, a worktree) wants to change my tooling.
---

# Public dotfiles vs the private overlay

dotfiles is a **public** GitHub repo. Everything committed there is
published. Work specifics live in the **private overlay**: a private
GitHub repo reached only through the `~/.private` symlink (its
`jrb/link` makes it; read `~/.private/CLAUDE.md` for its layout).
dotfiles never names the overlay's employer, products or people.

## Which side

| It mentions or depends on | Goes to |
|---|---|
| Generic tooling, editor, shell, tmux, wt, my working style | dotfiles |
| The employer, its products, repos, services, infra, deploy or ship tools, env/stack tooling, internal URLs, workspaces, ticket team keys, colleagues, customers, emails, account ids | overlay |
| A generic tool that needs a repo's specifics | dotfiles tool + a seam (below), specifics in the overlay |
| A secret | neither: the overlay's ignored `secrets/` |

When a rule is mostly generic with one work example, write the
generic rule in dotfiles and drop or neutralise the example (`ABC-123`,
"a work repo"). Don't copy work details "as an example".

## Seams (how generic tools reach private specifics)

- `.jrb/` in a repo's main checkout (symlinks into the overlay's
  `jrb/<repo>/`, trusted with `dev trust`): `dev`, `wt-prompt`,
  `wt-hook <event>` via `jrb-hook` (events listed in `bin/jrb-hook`:
  add/rm/forget, preview, shipping, nodeploy, merged-hint, sync). New
  repo-specific behaviour in wt & co = a new event, not an `if` on a
  repo name.
- Claude settings: overlay `jrb/claude/settings.json`, layered by the
  `claude` zsh wrapper through `$CLAUDE_EXTRA_SETTINGS` (`--settings`
  merges permissions, hooks, MCP servers and `autoMode`).
- Skills: overlay `jrb/skills/<name>`, symlinked into
  `claude/skills/` and git-excluded by `jrb/link`.
- Global agent rules for work repos: the overlay's root `CLAUDE.md`
  (loaded for any session under it).
- Env: the overlay's `.zshenv` (sourced via `~/.private/.zshenv`),
  e.g. `DEV_PASS_ENV`. Config files a dotfiles script reads:
  overlay `jrb/home/<path>` → `~/<path>` (`~/.config/...`).
- Executables: overlay `bin/` (on PATH as `~/.private/bin`).

After adding a skill or a `jrb/home` file, run `~/.private/jrb/link`.

## Before committing to dotfiles

`leak-check` runs in the global pre-commit and pre-push hooks against
the overlay's denylist. `--no-verify` (needed on main for the confirm
prompt) skips it, so then run `leak-check --staged` yourself first.
A hit means the line belongs in the overlay; never weaken the
denylist to pass. A new private name the list misses: add it to
`~/.private/jrb/dotfiles-denylist` in the same change.

Commit each side in its own repo, staging explicit paths.
