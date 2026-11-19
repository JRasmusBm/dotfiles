---
name: dictation
description: "Hammerspoon dictation setup. Load when discussing dictation, voice input, or CopyQ."
---

# Dictation

Reference this skill when the user mentions dictation, voice input, or the Dictate Hammerspoon spoon.

## How It Works

`Cmd+Shift+D` starts recording; the user decides when they're done:

- `Esc` submits: ffmpeg stops, whisper.cpp transcribes locally, the
  text is pasted (`Cmd+V`) and marked in CopyQ
  (`application/x-dictation`); old entries are cleaned (keeps last 2).
- `Cmd+Shift+D` while recording or transcribing aborts.
- Live preview: ffmpeg also cuts 2s chunks; each finished chunk is
  transcribed (greedy decoding, ~0.9s) into a panel at the
  bottom of the screen. The paste comes from one pass over the whole
  recording, since chunk cuts split words.
- Speed: Whisper's encode of its fixed 30s window dominates (~0.6s a
  call); model load is ~0.2s, so a resident whisper-server buys little.
  Shrinking the window (`-ac`) halves that but makes chunks repeat
  phrases and garble: don't.
- No speech (Silero VAD finds none) aborts with "Nothing recorded".
  VAD is why: without it Whisper hallucinates ("Thank you.") on silence.

Esc is bound only while recording, so it works normally otherwise.

## Voice trigger

Hands-free: say "Skalman" to start (as `Cmd+Shift+D`), "Kör hårt"
to submit (as Esc; `SUBMIT_CUT_SECONDS` of audio is cut from the end
so the word never reaches Whisper) and "Avbryt" to cancel. A phrase only counts in its state (start
when idle, submit/cancel while recording), so a stray hit costs at
most a cancelled recording, never a paste.

- `Dictate.spoon/wakeword/listen.py` runs as an `hs.task` of the
  spoon (it inherits Hammerspoon's mic permission; muting stops it,
  freeing the mic). openWakeWord, local only: no audio on disk, no
  network. It shares the default input with ffmpeg fine.
- `Cmd+Alt+Shift+D` mutes/unmutes. It mutes itself while a Zoom
  meeting runs (`CptHost` process) or a browser window's title
  starts with "Meet - " (polled every 5s).
- Models: `wakeword/models/*.onnx`, custom-trained by
  `wakeword/train.sh` from Swedish TTS clips plus real takes recorded
  with `wakeword/record.py` (`~/.local/share/wakeword/recordings`;
  hours on CPU). Thresholds
  in `WAKE` in the spoon start strict.
- Log: `~/.local/state/dictation/wakeword.log`, hits only (`name
  score state acted|ignored`), plus listener on/off and mute events.
  Count false triggers: `grep -c ignored` and acted starts you didn't
  say.
- Venv: `~/.local/share/wakeword/venv` (`install_dependencies/dictation`).
Replaced the macOS Shortcut "Dictate to Clipboard" (2026-11), which
stopped on its own after a pause.

## Key Files

- **Spoon:** `~/projects/dotfiles/window_manager/hammerspoon/Spoons/Dictate.spoon/init.lua`
- **Deps + models:** `install_dependencies/dictation` (ffmpeg,
  whisper-cpp, models in `~/.local/share/whisper`)
- Records from the default input device; Hammerspoon needs
  microphone permission.

## CopyQ Integration

Dictation entries are tagged with a custom MIME type so they can be identified and cleaned up without affecting normal clipboard history. The cleanup runs after each dictation.

To adjust how many dictation entries to keep, change `MAX_DICTATION_ITEMS` in the spoon.

## Troubleshooting

- **"Dictation failed" alert:** ffmpeg or whisper-cli failed to run;
  check paths and models (`install_dependencies/dictation`).
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
- **Voice trigger silent:** check the log for "listener exited"
  (missing venv or models) and that it isn't muted or in a call.
- **Changes not taking effect:** Reload Hammerspoon after editing the spoon.
