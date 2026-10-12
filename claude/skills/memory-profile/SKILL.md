---
name: memory-profile
description: Profile this Mac's memory use over time or after a crash — 'profile memory', 'what used my RAM', 'my computer crashed / ran out of memory', 'memory over the last day', 'who is eating memory', 'is an agent leaking'. Points at the minute-by-minute memlog, mem-top, Jetsam reports and the nvim LSP idle/reclaim machinery.
---

# Memory profile

36 GB machine shared by many tmux worktree sessions, nvims, Claude
sessions and dev stacks. On 2026-10-09 it OOM-crashed (~119 GB
resident + 16 GB compressed): ~12 nvim LSP pairs (tsserver ~3.6 GB +
type-aware eslint server 1.2–2.6 GB per ice-floe nvim) were the bulk.

## Data

- **memlog** — `$LOCAL_CONFIG/memlog/<YYYY-MM-DD>.log`, one snapshot
  a minute, 7 days kept. Snapshot = `=== <date> <time> pressure=<n>`,
  vm_stat pages (16 KB), then the top 60 processes by RSS as
  `<MB> <pid> <etime> <tmux session or -> <command>`. Session is
  resolved by ppid chain at capture time. `### … lsp-reclaim` lines
  mark watchdog suspends. Gaps = machine asleep.
- Written by launchd agent `com.jrasmusbm.memlog`
  (`launchd/com.jrasmusbm.memlog.plist`, runs `mem-snapshot;
  lsp-reclaim`). Errors: `memlog/errors.log`. Health:
  `launchctl print gui/$(id -u)/com.jrasmusbm.memlog` (runs, last exit).
- Snapshots before 2026-10-12 10:27 have session `-` and no
  pressure field (PATH bug under Hammerspoon), so attribute those by
  command only.
- **Jetsam reports** — `/Library/Logs/DiagnosticReports/
  JetsamEvent-*.ips`: written when macOS kills processes for memory.
  Line 1 is a header, the rest JSON: `processes[]` with `name`, `pid`,
  `rpages` (× `pageSize`), `age` (mach ticks, 24 MHz), `cpuTime`,
  `reason`. Names only — no command lines; cross-reference pids
  with memlog. `ResetCounter-*.diag` + `last reboot` date a crash.

## Tools

- `mem-top day [YYYY-MM-DD]` — hourly peak, compressor, pressure,
  top sessions at each peak, pressure events, reclaim actions.
- `mem-top [HH:MM] [YYYY-MM-DD]` — one snapshot: per-session MB and
  the biggest processes.
- `lsp-reclaim -f -n` — dry run: which nvim the watchdog would
  suspend now.

## Mitigations already in place

- nvim (`vim/lua/jrasmusbm/lsp/idle.lua`): ts_ls + eslint stop
  after `vim.g.lsp_idle_minutes` (10) unfocused, re-attach on focus;
  `:LspSuspend`/`:LspResume`. Each nvim answers
  `require("jrasmusbm.lsp.idle").status()` → `<unfocused_since> <n
  clients>` over `/tmp/nvim-server-*`.
- `lsp-reclaim`: at `kern.memorystatus_vm_pressure_level` ≥ 2,
  suspends the longest-unfocused nvim (≥ 5 min), one per minute.
- macOS has no usable per-process/tree memory cap (no cgroups,
  `ulimit -v` rejected, launchd ResidentSetSize ignored) — don't
  retry those.

## Method

1. `mem-top day` for the shape; find the peaks and pressure events.
2. `mem-top HH:MM` at each peak; group by kind (tsserver.js,
   vscode-eslint, claude, dev stack node, tsc/mocha, Brave/Chrome,
   mds) and by session.
3. For a crash, read the Jetsam report nearest the reboot and match
   its large pids against the memlog snapshot just before.
4. Long-lived big node procs with little CPU = idle servers;
   short-lived = builds/tests. Classify by command, not by name
   (a worktree slug can contain "mcp").
