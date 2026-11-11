---
name: dictation
description: "Hammerspoon dictation setup. Load when discussing dictation, voice input, or CopyQ."
---

# Dictation

Reference this skill when the user mentions dictation, voice input, or the Dictate Hammerspoon spoon.

## How It Works

Dictation is triggered by `Cmd+Shift+D` via Hammerspoon. The flow:

1. Hammerspoon runs the macOS Shortcut "Dictate to Clipboard"
2. The shortcut captures speech and places text in the clipboard
3. Hammerspoon marks the clipboard item with a custom MIME type (`application/x-dictation`)
4. Hammerspoon pastes the text with `Cmd+V`
5. Old dictation entries are cleaned up from CopyQ (keeps last 2)

## Key Files

- **Spoon:** `~/projects/dotfiles/window_manager/hammerspoon/Spoons/Dictate.spoon/init.lua`
- **macOS Shortcut:** "Dictate to Clipboard" (managed in Shortcuts.app)

## CopyQ Integration

Dictation entries are tagged with a custom MIME type so they can be identified and cleaned up without affecting normal clipboard history. The cleanup runs after each dictation.

To adjust how many dictation entries to keep, change `MAX_DICTATION_ITEMS` in the spoon.

## Troubleshooting

- **"Dictation failed" alert:** The macOS Shortcut failed. Check Shortcuts.app.
- **Clipboard not cleaned up:** CopyQ may not be running, or the path `/Applications/CopyQ.app/Contents/MacOS/CopyQ` is wrong.
- **"CopyQ not responding" alert / CopyQ seems crashed:** usually a hung
  server, not a crash (no `.ips` report; `open -a CopyQ` fails with
  -1712). `pgrep -lx CopyQ` shows it alive with stuck `eval` children.
  Fix: `pkill -9 -x CopyQ; open -a CopyQ` (a hung server ignores
  SIGTERM); `CopyQ eval 'size()'` answering confirms. App Nap is
  disabled via
  `defaults write io.github.hluk.CopyQ NSAppSleepDisabled -bool YES`.
  Hung servers recurred on 9.1.0 (2024); upgraded to 17.0.0 on
  2026-11-11. If it still hangs, `sample <pid>` the server before
  killing it: the log never shows the hang.
- **Upgrading CopyQ:** the Homebrew cask is disabled (fails Gatekeeper,
  so `brew upgrade` never updates it). Install the GitHub release dmg
  (`-m1` on Apple Silicon) and check its sha256 against the release
  asset digest. Then run `codesign --force --deep --sign -` on the app:
  without it macOS kills it on launch ("Code Signature Invalid" in a
  `.ips` report, `open -a` says "Unable to find application").
- **Changes not taking effect:** Reload Hammerspoon after editing the spoon.
