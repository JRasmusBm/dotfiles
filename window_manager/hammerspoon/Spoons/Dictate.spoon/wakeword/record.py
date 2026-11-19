"""Record takes of each wake phrase (and free talk) for training.

    ~/.local/share/wakeword/venv/bin/python record.py [TAKES]

For each phrase, press Enter, then say it on every "▶" cue: TAKES
takes (default 40), SECONDS each. Then optionally record free talk
(negatives). Clips go to ~/.local/share/wakeword/recordings/<name>/,
numbered after what is already there, so re-running adds takes.
"""

import os
import sys
import time
import wave

import numpy as np
import sounddevice as sd

RATE = 16000
SECONDS = 2.0
GAP = 0.4
TALK_SECONDS = 300
PHRASES = {
    "skalman": "Skalman",
    "kor_hart": "Kör hårt",
    "avbryt": "Avbryt",
}
ROOT = os.path.expanduser("~/.local/share/wakeword/recordings")


def save(path, audio):
    with wave.open(path, "wb") as w:
        w.setnchannels(1)
        w.setsampwidth(2)
        w.setframerate(RATE)
        w.writeframes(audio.tobytes())


def next_index(folder):
    os.makedirs(folder, exist_ok=True)
    taken = [int(f[:4]) for f in os.listdir(folder) if f[:4].isdigit()]
    return max(taken, default=-1) + 1


def record(seconds):
    audio = sd.rec(int(seconds * RATE), samplerate=RATE, channels=1,
                   dtype="int16")
    sd.wait()
    return audio


def phrase_takes(name, phrase, takes):
    folder = os.path.join(ROOT, name)
    start = next_index(folder)
    input(f"\n{phrase!r}: {takes} takes. Enter to start… ")
    for i in range(takes):
        print(f"  ▶ {phrase}   ({i + 1}/{takes})", flush=True)
        save(os.path.join(folder, f"{start + i:04d}.wav"),
             record(SECONDS))
        time.sleep(GAP)


def talk():
    answer = input(f"\nRecord {TALK_SECONDS // 60} min of free talk "
                   "(no wake words) as negatives? [y/N] ")
    if answer.lower() != "y":
        return
    folder = os.path.join(ROOT, "talk")
    path = os.path.join(folder, f"{next_index(folder):04d}.wav")
    print("  ● talking… (Ctrl-C stops early)", flush=True)
    frames = []
    with sd.InputStream(samplerate=RATE, channels=1, dtype="int16") as s:
        try:
            end = time.monotonic() + TALK_SECONDS
            while time.monotonic() < end:
                frames.append(s.read(RATE)[0])
        except KeyboardInterrupt:
            pass
    save(path, np.concatenate(frames))


def main():
    takes = int(sys.argv[1]) if len(sys.argv) > 1 else 40
    print(f"Mic: {sd.query_devices(kind='input')['name']}")
    print("Vary it: normal, fast, quiet, a bit away from the mic.")
    for name, phrase in PHRASES.items():
        phrase_takes(name, phrase, takes)
    talk()
    print(f"\nSaved under {ROOT}")


if __name__ == "__main__":
    main()
