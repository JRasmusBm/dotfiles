#!/bin/sh
# Train the Dictate.spoon wake word models with openWakeWord (macOS, CPU/MPS).
#
# Usage: sh train.sh [setup | NAME ...]
#
# Phrases, per-phrase Swedish near-miss negatives and the false-accept
# cap that picks each threshold live in train.yaml (models:); each model
# NAME becomes models/NAME.onnx next to this script. With no NAME every
# model in train.yaml is trained; `setup` stops after the shared setup.
# Positives: Swedish piper voices plus libritts speakers fed espeak-sv
# phonemes, and the user's takes from ~/.local/share/wakeword/recordings/
# NAME/*.wav (30% held out to measure recall), heavily augmented.
# Negatives: ACAV100M, FLEURS Swedish speech, the near-misses, the other
# models' phrases and takes, and recordings/talk/*.wav if present. Without
# takes it trains on synthetic clips only. Then all models are evaluated
# together; the report (recall on held-out takes, false accepts per hour on
# English, Swedish and talk audio, cross-phrase scores, threshold, median
# take duration) lands in $WAKEWORD_ROOT/report.txt.
#
# Everything else (venv, pinned sources, TTS voices, ACAV100M features,
# FLEURS, room impulse responses, AudioSet noise, clips, features) lives in
# $WAKEWORD_ROOT (default ~/.local/share/wakeword/train, ~30 GB).
# Idempotent: finished steps are skipped. To redo one, delete its output
# (work/NAME/<split>/, work/NAME/*.npy, work/takes/ or models/NAME.onnx).
#
# Time on an M-series Mac: first setup ~30 min (downloads, FLEURS
# features), then about 1 h per phrase (TTS ~18 min, augmentation ~6 min,
# training ~33 min), eval ~7 min.
set -eu

here=$(cd "$(dirname "$0")" && pwd)
root=${WAKEWORD_ROOT:-$HOME/.local/share/wakeword/train}
py=$root/venv/bin/python
hf=https://huggingface.co/datasets
feat=$hf/davidscripka/openwakeword_features/resolve/main
psg=https://github.com/rhasspy/piper-sample-generator
export WAKEWORD_ROOT="$root" OMP_NUM_THREADS=6 MKL_NUM_THREADS=6 \
  PYTHONWARNINGS=ignore TQDM_MININTERVAL=30 \
  PYTHONPATH="$root/src/piper-sample-generator"
mkdir -p "$root/src" "$root/tts" "$root/data" "$root/work" "$here/models"

clone() {
  [ -d "$root/src/$1" ] || git clone -q "$2" "$root/src/$1"
  git -C "$root/src/$1" checkout -q "$3"
}

fetch() {
  [ -f "$1" ] || { curl -fsSL -C - -o "$1.part" "$2" && mv "$1.part" "$1"; }
}

step() {
  echo "== $* $(date +%T)"
  nice -n 10 "$py" "$here/oww.py" "$@"
}

clone openWakeWord https://github.com/dscripka/openWakeWord.git \
  368c03716d1e92591906a84949bc477f3a834455
clone piper-sample-generator $psg.git \
  2971426a55072f7d22fec416ca7800df8bd23207

[ -x "$py" ] || uv venv -q -p 3.11 "$root/venv"
if ! cmp -s "$here/requirements.txt" "$root/venv/requirements.txt"; then
  export VIRTUAL_ENV="$root/venv"
  uv pip install -q -r "$here/requirements.txt"
  uv pip install -q --no-deps -e "$root/src/openWakeWord"
  cp "$here/requirements.txt" "$root/venv/requirements.txt"
fi
"$py" -c 'import openwakeword.utils as u; u.download_models(["-"])' \
  >/dev/null 2>&1

fetch "$root/tts/en_US-libritts_r-medium.pt" \
  $psg/releases/download/v2.0.0/en_US-libritts_r-medium.pt
cp "$root/src/piper-sample-generator/models/en_US-libritts_r-medium.pt.json" \
  "$root/tts/"
fetch "$root/data/acav.npy" \
  $feat/openwakeword_features_ACAV100M_2000_hrs_16bit.npy
fetch "$root/data/validation_set_features.npy" \
  $feat/validation_set_features.npy
voices=https://huggingface.co/rhasspy/piper-voices/resolve/main/sv/sv_SE
mkdir -p "$root/tts/sv" "$root/data/fleurs"
for v in nst lisa alma; do
  for x in onnx onnx.json; do
    fetch "$root/tts/sv/sv_SE-$v-medium.$x" \
      "$voices/$v/medium/sv_SE-$v-medium.$x"
  done
done
fleurs=$hf/google/fleurs/resolve/main/data/sv_se
for s in train dev test; do
  fetch "$root/data/fleurs/$s.tar.gz" "$fleurs/audio/$s.tar.gz"
done
for i in 00 01; do
  fetch "$root/data/audioset_$i.parquet" \
    $hf/agkphysics/AudioSet/resolve/main/data/bal_train/$i.parquet
done
step prep
[ "${1:-}" != setup ] || exit 0

[ $# -gt 0 ] || set -- $(step names | tail -1)
for name in "$@"; do
  step gen "$name"
  step feat "$name"
  step train "$name" "$here/models"
done
step eval "$here/models"
