"""Listen on the default mic for wake phrases; print one line per hit.

    listen.py NAME=MODEL.onnx:THRESHOLD ...

Prints "NAME SCORE" to stdout when a model's score crosses its
threshold. Audio stays in memory: nothing is written to disk and
nothing goes over the network. Exits when stdin closes.
Runs in the venv from install_dependencies/dictation.
"""

import os
import sys
import threading
import time

import sounddevice as sd
from openwakeword.model import Model

RATE = 16000
FRAME = 1280
COOLDOWN_SECONDS = 2.0


def parse(args):
    models, thresholds = {}, {}
    for arg in args:
        name, spec = arg.split("=", 1)
        path, threshold = spec.rsplit(":", 1)
        models[name] = path
        thresholds[name] = float(threshold)
    return models, thresholds


def exit_on_eof():
    sys.stdin.read()
    os._exit(0)


def main():
    threading.Thread(target=exit_on_eof, daemon=True).start()
    models, thresholds = parse(sys.argv[1:])
    model = Model(
        wakeword_models=list(models.values()),
        inference_framework="onnx",
        vad_threshold=0.5,
    )
    keys = {os.path.splitext(os.path.basename(p))[0]: n
            for n, p in models.items()}
    quiet_until = 0.0
    with sd.InputStream(samplerate=RATE, channels=1, dtype="int16",
                        blocksize=FRAME) as stream:
        while True:
            audio, _ = stream.read(FRAME)
            scores = model.predict(audio[:, 0])
            now = time.monotonic()
            if now < quiet_until:
                continue
            for key, score in scores.items():
                name = keys[key]
                if score >= thresholds[name]:
                    print(f"{name} {score:.3f}", flush=True)
                    model.reset()
                    quiet_until = now + COOLDOWN_SECONDS
                    break


if __name__ == "__main__":
    try:
        main()
    except (BrokenPipeError, KeyboardInterrupt):
        sys.exit(0)
