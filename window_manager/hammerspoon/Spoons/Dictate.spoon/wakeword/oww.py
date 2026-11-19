"""Steps of train.sh: prep | gen NAME | feat NAME | train NAME DIR [ENGINES]
| eval DIR.

Each step skips work whose output already exists under $WAKEWORD_ROOT.
Real takes come from $WAKEWORD_ROOT/../recordings/{NAME,talk}/*.wav.
"""
import glob
import io
import itertools
import logging
import os
import random
import sys
import tarfile
import uuid
from math import gcd
from pathlib import Path

import numpy as np
import soundfile as sf
import yaml
from numpy.lib.stride_tricks import sliding_window_view
from scipy.signal import resample_poly

ROOT = Path(os.environ["WAKEWORD_ROOT"])
DATA, WORK, REC = ROOT / "data", ROOT / "work", ROOT.parent / "recordings"
CFG = yaml.safe_load(open(Path(__file__).with_name("train.yaml")))
NAMES = list(CFG["models"])
SPLITS = {"positive_train": "n_samples", "positive_test": "n_samples_val",
          "negative_train": "n_samples", "negative_test": "n_samples_val"}
ENGINES = ("sv", "lt")
GRID = [0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 0.95, 0.98, 0.99]
logging.basicConfig(level=logging.INFO, format="%(asctime)s %(message)s")
random.seed(0)


def wavs(d):
    return sorted(glob.glob(f"{d}/*.wav"))


def to16k(x, sr):
    if x.ndim > 1:
        x = x.mean(axis=1)
    g = gcd(16000, sr)
    return resample_poly(x, 16000 // g, sr // g) if sr != 16000 else x


def write16k(path, x, sr=16000):
    sf.write(path, np.clip(to16k(x, sr), -1, 1), 16000, subtype="PCM_16")


def pcm(x):
    return (np.clip(x, -1, 1) * 32767).astype(np.int16)


def frames(af, x):
    return af._get_embeddings(pcm(x)) if len(x) >= 16000 else np.zeros((0, 96))


def audio_features():
    from openwakeword.utils import AudioFeatures
    return AudioFeatures(inference_framework="onnx", ncpu=6)


def fleurs():
    if (DATA / "sv_test.npy").exists():
        return
    af = audio_features()
    out = {"train": [], "dev": [], "test": []}
    for split in out:
        with tarfile.open(DATA / f"fleurs/{split}.tar.gz") as t:
            for m in t:
                if m.isfile() and m.name.endswith(".wav"):
                    x, sr = sf.read(io.BytesIO(t.extractfile(m).read()))
                    out[split].append(frames(af, to16k(x, sr)))
    w = np.vstack([sliding_window_view(f, (16, 96))[::4, 0]
                   for f in out["train"] if len(f) >= 16])
    np.save(DATA / "sv_train.npy",
            w[np.random.default_rng(0).permutation(len(w))].astype(np.float16))
    np.save(DATA / "sv_dev.npy", np.vstack(out["dev"]).astype(np.float32))
    np.save(DATA / "sv_test.npy", np.vstack(out["test"]).astype(np.float32))


def trim(x):
    r = np.sqrt(np.mean(x[:len(x) // 320 * 320].reshape(-1, 320) ** 2, 1))
    on = np.flatnonzero(r > max(np.percentile(r, 10) * 4, r.max() * 0.05))
    a, b = on[0] * 320, (on[-1] + 1) * 320
    return x[max(0, a - 1600):b + 1600], (b - a) / 16000


def takes():
    d = WORK / "takes"
    if (d / ".done").exists() or not all(
            wavs(REC / n) for n in NAMES):
        return
    rng = np.random.default_rng(0)
    dur = {}
    for n in NAMES:
        for s in ("train", "test", "aug"):
            (d / n / s).mkdir(parents=True, exist_ok=True)
        dur[n] = []
        for i, f in enumerate(wavs(REC / n)):
            x, sr = sf.read(f)
            x = to16k(x, sr)
            y, t = trim(x)
            dur[n].append(t)
            s = "test" if i % 10 in (3, 6, 9) else "train"
            write16k(d / n / s / Path(f).name, y)
            if s == "test":
                write16k(d / n / s / f"raw_{Path(f).name}", x)
        for f in wavs(d / n / "train"):
            x = sf.read(f)[0]
            for r in range(CFG["real_copies"]):
                s = rng.uniform(0.88, 1.12)
                y = resample_poly(x, 100, round(100 * s)) * rng.uniform(.5, 1.5)
                write16k(d / n / "aug" / f"{r}_{Path(f).name}", y)
        clips = wavs(d / n / "aug")
        random.shuffle(clips)
        featurize(clips, d / f"{n}.npy")
    (d / "durations.yaml").write_text(yaml.safe_dump(
        {n: {"median_s": float(np.median(v)), "n": len(v)}
         for n, v in dur.items()}))
    (d / ".done").touch()


def talk():
    d = WORK / "talk"
    if (d / "test.npy").exists() or not wavs(REC / "talk"):
        return
    d.mkdir(exist_ok=True)
    x = np.concatenate([to16k(*sf.read(f)) for f in wavs(REC / "talk")])
    cut = int(len(x) * 0.7)
    (d / "chunks").mkdir(exist_ok=True)
    for i in range(0, cut - 32000, 8000):
        write16k(d / "chunks" / f"{i:09d}.wav", x[i:i + 32000])
    clips = wavs(d / "chunks") * CFG["talk_copies"]
    random.shuffle(clips)
    featurize(clips, d / "train.npy")
    np.save(d / "test.npy", frames(audio_features(), x[cut:]))


def prep():
    from huggingface_hub import snapshot_download
    if not wavs(DATA / "mit/16khz"):
        snapshot_download("davidscripka/MIT_environmental_impulse_responses",
                          repo_type="dataset", allow_patterns="16khz/*.wav",
                          local_dir=DATA / "mit")
    bg = DATA / "background"
    if not (bg / ".done").exists():
        import pyarrow.parquet as pq
        bg.mkdir(exist_ok=True)
        for f in sorted(DATA.glob("audioset_*.parquet")):
            for b in pq.ParquetFile(f).iter_batches(batch_size=64):
                for row in b.to_pylist():
                    x, sr = sf.read(io.BytesIO(row["audio"]["bytes"]))
                    write16k(bg / f"{row['video_id']}.wav", x, sr)
        (bg / ".done").touch()
    fleurs()
    if not all(wavs(REC / n) for n in NAMES):
        print(f"warning: no takes in {REC}/{{{','.join(NAMES)}}}, "
              "training on synthetic clips only")
    takes()
    talk()


class ShuffledProduct:
    def __getattr__(self, k):
        return getattr(itertools, k)

    @staticmethod
    def product(*a):
        p = list(itertools.product(*a))
        random.shuffle(p)
        return p


def ipa(ts):
    from piper.phonemize_espeak import EspeakPhonemizer
    e = EspeakPhonemizer()
    return ["".join(itertools.chain(*e.phonemize("sv", t))) for t in ts]


def phones(name):
    m = CFG["models"][name]
    return m.get("ipa") or ipa([m["phrase"]])


def texts(name, split):
    if split.startswith("positive"):
        return phones(name)
    t = ipa(CFG["models"][name]["negatives"]) + [
        p for o in NAMES if o != name for p in phones(o)] * 3
    random.shuffle(t)
    return t


def gen(name):
    import piper_sample_generator.__main__ as psg
    psg.it = ShuffledProduct()
    logging.getLogger().setLevel(logging.INFO)
    for split, key in SPLITS.items():
        test = split.endswith("test")
        for eng in ENGINES:
            share = CFG["libritts_share"] if eng == "lt" else \
                1 - CFG["libritts_share"]
            out = WORK / name / split / eng
            raw = WORK / name / split / f"{eng}_22k"
            n = round(CFG[key] * share) - len(wavs(out)) - len(wavs(raw))
            files = [uuid.uuid4().hex + ".wav" for _ in range(max(n, 0))]
            if n > 0 and eng == "lt":
                psg.generate_samples(
                    texts(name, split), raw,
                    ROOT / "tts/en_US-libritts_r-medium.pt",
                    max_samples=n, batch_size=CFG["tts_batch_size"],
                    max_speakers=CFG["max_speakers"], file_names=files,
                    slerp_weights=(0.3, 0.5, 0.7),
                    length_scales=(0.8, 1.0, 1.2, 1.4),
                    noise_scales=(1.0 if test else 0.9,),
                    noise_scale_ws=(1.0 if test else 0.9,),
                    phoneme_input=True)
            elif n > 0:
                psg.generate_samples_onnx(
                    texts(name, split), raw,
                    [str(ROOT / f"tts/sv/{v}.onnx") for v in CFG["voices"]],
                    max_samples=n, file_names=files,
                    length_scales=(0.8, 0.9, 1.0, 1.15, 1.3, 1.45),
                    noise_scales=(0.5, 0.8, 1.0),
                    noise_scale_ws=(0.6, 0.8, 1.0, 1.2), phoneme_input=True)
            out.mkdir(parents=True, exist_ok=True)
            for f in wavs(raw):
                x, sr = sf.read(f)
                write16k(out / Path(f).name, x, sr)
                os.remove(f)


def seed(n):
    import torch
    random.seed(n)
    np.random.seed(n)
    torch.manual_seed(n)


def augmented(clips, length=None):
    from openwakeword.data import augment_clips
    return augment_clips(clips, total_length=length or CFG["clip_length"],
                         batch_size=16,
                         background_clip_paths=wavs(DATA / "background"),
                         RIR_paths=wavs(DATA / "mit/16khz"))


def featurize(clips, f):
    from openwakeword.utils import compute_features_from_generator
    tmp = f.with_suffix(".tmp.npy")
    compute_features_from_generator(
        augmented(clips), n_total=len(clips),
        clip_duration=CFG["clip_length"], output_file=str(tmp),
        device="cpu", ncpu=6)
    tmp.rename(f)


def feat(name):
    for split in SPLITS:
        for eng in ENGINES:
            f = WORK / name / f"{split}_{eng}.npy"
            if not f.exists():
                featurize(wavs(WORK / name / split / eng), f)


def fp_halves():
    v = np.load(DATA / "validation_set_features.npy")
    return v[:len(v) // 2], v[len(v) // 2:]


def train(name, models, engines="sv,lt"):
    import torch
    from openwakeword.data import mmap_batch_generator
    from openwakeword.train import Model
    if (Path(models) / f"{name}.onnx").exists():
        return
    torch.set_num_threads(6)
    d, eng = WORK / name, engines.split(",")
    n = dict(CFG["batch_n_per_class"])
    files = {"ACAV100M": DATA / "acav.npy",
             "swedish": DATA / "sv_train.npy",
             "talk": WORK / "talk/train.npy",
             "real": WORK / f"takes/{name}.npy"}
    for e in eng:
        for k in ("positive", "negative"):
            files[f"{k}_{e}"] = d / f"{k}_train_{e}.npy"
            n[f"{k}_{e}"] = n[k] // len(eng)
    for o in NAMES:
        if o != name:
            files[f"real_neg_{o}"] = WORK / f"takes/{o}.npy"
            n[f"real_neg_{o}"] = n["real_neg"] // (len(NAMES) - 1)
    files = {k: str(v) for k, v in files.items() if v.exists()}
    print("batch:", {k: n[k] for k in files})
    batches = mmap_batch_generator(
        files, n_per_class={k: n[k] for k in files},
        label_transform_funcs={
            k: (lambda y, v=int(k.startswith("positive") or k == "real"):
                [v] * len(y)) for k in files})

    class Batches(torch.utils.data.IterableDataset):
        def __iter__(self):
            return batches

    class Windows:
        def __init__(self, v):
            self.w = sliding_window_view(v, (16, 96))[:, 0]

        def __iter__(self):
            for i in range(0, len(self.w), 50000):
                x = np.ascontiguousarray(self.w[i:i + 50000])
                x = torch.from_numpy(x.astype(np.float32))
                yield x, torch.zeros(len(x))

    pos = np.vstack([np.load(d / f"positive_test_{e}.npy") for e in eng])
    neg = np.vstack([np.load(d / f"negative_test_{e}.npy") for e in eng])
    x_val = [(torch.from_numpy(np.vstack((pos, neg))),
              torch.from_numpy(np.r_[np.ones(len(pos)), np.zeros(len(neg))]
                               .astype(np.float32)))]
    fp = np.vstack((fp_halves()[0], np.load(DATA / "sv_dev.npy")))
    oww = Model(n_classes=1, input_shape=pos.shape[1:], model_type="dnn",
                layer_dim=CFG["layer_size"], seconds_per_example=1.28)
    best = oww.auto_train(
        torch.utils.data.DataLoader(Batches(), batch_size=None), x_val,
        Windows(fp), steps=CFG["steps"],
        max_negative_weight=CFG["max_negative_weight"],
        target_fp_per_hour=CFG["target_false_positives_per_hour"])
    oww.export_model(best, name, str(d))
    os.replace(d / f"{name}.onnx", Path(models) / f"{name}.onnx")


def events(p, thr, gap=25):
    n, last = 0, -gap - 1
    for i in np.flatnonzero(p >= thr):
        n += i - last > gap
        last = i
    return n


def stream_scores(oww, names, clips):
    out = []
    for a in clips:
        oww.reset()
        a = np.r_[np.zeros(8000, np.int16), a, np.zeros(8000, np.int16)]
        mx = dict.fromkeys(names, 0.0)
        for i in range(0, len(a) - 1279, 1280):
            for k, v in oww.predict(a[i:i + 1280]).items():
                mx[k] = max(mx[k], float(v))
        out.append([mx[k] for k in names])
    return np.array(out).reshape(-1, len(names))


def window_scores(s, f):
    i = s.get_inputs()[0].name
    w = sliding_window_view(f, (16, 96))[:, 0].astype(np.float32)
    return np.array([s.run(None, {i: w[j:j + 1]})[0].item()
                     for j in range(len(w))])


def evaluate(models):
    import onnxruntime as ort
    from openwakeword.model import Model as OWW
    fa_sets = {"en": fp_halves()[1], "sv": np.load(DATA / "sv_test.npy")}
    if (WORK / "talk/test.npy").exists():
        fa_sets["talk"] = np.load(WORK / "talk/test.npy")
    hours = {k: len(v) * 0.08 / 3600 for k, v in fa_sets.items()}
    fa = {n: {k: window_scores(ort.InferenceSession(f"{models}/{n}.onnx"), v)
              for k, v in fa_sets.items()} for n in NAMES}
    oww = OWW(wakeword_models=[f"{models}/{n}.onnx" for n in NAMES],
              inference_framework="onnx")
    real = (WORK / "takes/.done").exists()
    clean, noisy, synth = {}, {}, {}
    for p in NAMES:
        synth[p] = stream_scores(oww, NAMES, (
            sf.read(c, dtype="int16")[0] for e in ENGINES
            for c in wavs(WORK / p / f"positive_test/{e}")))
        if real:
            t = WORK / "takes" / p / "test"
            clean[p] = stream_scores(oww, NAMES, (
                sf.read(c, dtype="int16")[0] for c in wavs(t)
                if Path(c).name.startswith("raw_")))
            seed(0)
            trimmed = [c for c in wavs(t)
                       if not Path(c).name.startswith("raw_")]
            noisy[p] = stream_scores(oww, NAMES, (
                a for b in augmented(trimmed * 5) for a in b))
    lines = ["false-accept sets (h): " + ", ".join(
        f"{k} {v:.2f}" for k, v in hours.items())]
    if real:
        lines.append("median take duration (s): " + (
            WORK / "takes/durations.yaml").read_text().replace("\n", " "))
    for k, n in enumerate(NAMES):
        rec, cap = None, CFG["models"][n]["max_fa"]
        lines.append(
            f"\n{n}  thr  recall real clean/noisy  synth  FA/h "
            f"{'/'.join(fa_sets)}  cross-hits  cross-max")
        for t in GRID:
            other = np.r_[tuple(s[p][:, k] for s in (clean, noisy, synth)
                                if s for p in NAMES if p != n)]
            fah = {s: events(fa[n][s], t) / hours[s] for s in fa_sets}
            hits = int((other >= t).sum())
            rc = (f"{(clean[n][:, k] >= t).mean():.3f}/"
                  f"{(noisy[n][:, k] >= t).mean():.3f}") if real else "-"
            lines.append(
                f"  {t:.2f}  {rc}  {(synth[n][:, k] >= t).mean():.3f}  "
                + "/".join(f"{v:.2f}" for v in fah.values())
                + f"  {hits}/{len(other)}  {other.max():.3f}")
            if rec is None and max(fah.values()) <= cap and hits == 0:
                rec = t
        lines.append(f"  recommended threshold: {rec or GRID[-1]}")
        for p in NAMES:
            if p != n:
                lines.append(f"  max on {p}: " + " ".join(
                    f"{lbl} {s[p][:, k].max():.3f}" for lbl, s in
                    (("real", clean), ("real-noisy", noisy),
                     ("synth", synth)) if s))
    report = "\n".join(lines)
    (ROOT / "report.txt").write_text(report + "\n")
    print(report)


if __name__ == "__main__":
    cmd, *args = sys.argv[1:]
    {"prep": prep, "gen": gen, "feat": feat, "train": train,
     "eval": evaluate, "names": lambda: print(*NAMES)}[cmd](*args)
