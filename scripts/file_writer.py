import csv
from pathlib import Path
from file_info import FileInfo


def read_config(path):
    resolved = Path(path).resolve()
    with open(resolved) as f:
        files = [
            FileInfo(
                is_dir=is_dir in ["True", "true", "1"],
                source=Path(source).resolve(),
                target=Path(target),
            )
            for is_dir, source, target in csv.reader(f)
        ][1:]
    return files


def write_config(path, files):
    resolved = Path(path).resolve()
    if not resolved.exists():
        resolved.touch()
    with open(resolved, "w") as f:
        writer = csv.writer(f)
        writer.writerow(["is_dir", "source", "target"])
        for the_file in files:
            writer.writerow(
                [
                    "True" if the_file.is_dir else "False",
                    the_file.source,
                    the_file.target,
                ]
            )


if __name__ == "__main__":
    config = read_config("./files.csv")
    print(config)
    write_config("./tmp.csv", config)
